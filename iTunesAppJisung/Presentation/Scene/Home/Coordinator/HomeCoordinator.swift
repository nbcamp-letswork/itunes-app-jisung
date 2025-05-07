import XCoordinator

final class HomeCoordinator: NavigationCoordinator<HomeRoute> {
    override func prepareTransition(for route: HomeRoute) -> NavigationTransition {
        switch route {
        case .home:
            let viewController = HomeViewController()

            return .set([viewController])
        }
    }
}
