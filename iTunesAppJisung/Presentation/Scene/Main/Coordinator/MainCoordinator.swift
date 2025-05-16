import XCoordinator

final class MainCoordinator: NavigationCoordinator<MainRoute> {
    private let mainViewController: MainViewController
    private let homeViewController: HomeViewController
    private let searchViewModel: SearchViewModel
    private var resultCoordinator: ResultCoordinator?

    init(
        mainViewController: MainViewController,
        homeViewController: HomeViewController,
        searchViewModel: SearchViewModel
    ) {
        self.mainViewController = mainViewController
        self.homeViewController = homeViewController
        self.searchViewModel = searchViewModel

        super.init(initialRoute: .main)
    }

    override func prepareTransition(for route: MainRoute) -> NavigationTransition {
        switch route {
        case .main:
            homeViewController.delegate = mainViewController

            mainViewController.router = weakRouter
            mainViewController.embed(homeViewController)

            return .set([mainViewController])
        case .home:
            unembed()

            mainViewController.embed(homeViewController)

            return .none()
        case .suggestion:
            unembed()

            let suggestionViewController = SuggestionViewController(searchViewModel: searchViewModel)
            suggestionViewController.delegate = mainViewController

            mainViewController.embed(suggestionViewController)

            return .none()
        case .result:
            unembed()

            let resultViewController = ResultViewController(searchViewModel: searchViewModel)
            resultViewController.delegate = mainViewController

            resultCoordinator = ResultCoordinator(rootViewController: resultViewController)
            resultViewController.router = resultCoordinator?.weakRouter

            mainViewController.embed(resultViewController)

            return .none()
        }
    }

    private func unembed() {
        guard let child = mainViewController.children.last else {
            return
        }

        mainViewController.unembed(child)
    }
}
