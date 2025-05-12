import XCoordinator

final class MainCoordinator: NavigationCoordinator<MainRoute> {
    private let mainViewController: MainViewController
    private let homeViewController: HomeViewController
    private let suggestionViewController: SuggestionViewController

    init(
        mainViewController: MainViewController,
        homeViewController: HomeViewController,
        suggestionViewController: SuggestionViewController
    ) {
        self.mainViewController = mainViewController
        self.homeViewController = homeViewController
        self.suggestionViewController = suggestionViewController

        super.init(initialRoute: .main)
    }

    override func prepareTransition(for route: MainRoute) -> NavigationTransition {
        switch route {
        case .main:
            homeViewController.delegate = mainViewController

            mainViewController.router = unownedRouter
            mainViewController.embed(homeViewController)

            return .set([mainViewController])
        case .home:
            unembed()

            mainViewController.embed(homeViewController)

            return .none()
        case .suggestion:
            unembed()

            mainViewController.embed(suggestionViewController)

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
