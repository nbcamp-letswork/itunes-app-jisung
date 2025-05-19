import Swinject
import XCoordinator

final class MainCoordinator: NavigationCoordinator<MainRoute> {
    private let container: Swinject.Container
    private let mainViewController: MainViewController
    private var homeCoordinator: HomeCoordinator!
    private var resultCoordinator: ResultCoordinator!

    init(container: Swinject.Container) {
        self.container = container
        mainViewController = container.resolve(MainViewController.self)!

        super.init(initialRoute: .main)
    }

    override func prepareTransition(for route: MainRoute) -> NavigationTransition {
        switch route {
        case .main:
            mainViewController.router = weakRouter

            return .set([mainViewController])

        case .home:
            unembed()

            let homeViewController = container.resolve(HomeViewController.self)!
            homeCoordinator = HomeCoordinator(
                rootViewController: homeViewController,
                delegate: mainViewController,
                container: container
            )

            mainViewController.embed(homeCoordinator.rootViewController)

            return .none()

        case .suggestion:
            unembed()

            let suggestionViewController = container.resolve(SuggestionViewController.self)!
            suggestionViewController.delegate = mainViewController

            mainViewController.embed(suggestionViewController)
            return .none()

        case .result:
            unembed()

            let resultViewController = container.resolve(ResultViewController.self)!
            resultCoordinator = ResultCoordinator(
                rootViewController: resultViewController,
                delegate: mainViewController,
                container: container
            )

            mainViewController.embed(resultCoordinator.rootViewController)

            return .none()
        }
    }

    private func unembed() {
        guard let child = mainViewController.children.last else { return }

        mainViewController.unembed(child)
    }
}
