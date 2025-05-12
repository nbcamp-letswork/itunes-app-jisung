import XCoordinator

final class MainCoordinator: NavigationCoordinator<MainRoute> {
    private let mainViewController: MainViewController
    private let homeViewController: HomeViewController

    init(
        mainViewController: MainViewController,
        homeViewController: HomeViewController
    ) {
        self.mainViewController = mainViewController
        self.homeViewController = homeViewController

        super.init(initialRoute: .main)
    }

    override func prepareTransition(for route: MainRoute) -> NavigationTransition {
        switch route {
        case .main:
            homeViewController.delegate = mainViewController

            mainViewController.embed(homeViewController)

            return .set([mainViewController])
        }
    }
}
