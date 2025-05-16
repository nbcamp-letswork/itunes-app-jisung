import Swinject
import XCoordinator

final class HomeCoordinator: ViewCoordinator<HomeRoute> {
    private let container: Swinject.Container

    init(
        rootViewController: HomeViewController,
        delegate: MainViewController,
        container: Swinject.Container
    ) {
        self.container = container

        super.init(rootViewController: rootViewController)

        rootViewController.delegate = delegate
        rootViewController.router = weakRouter
    }

    override func prepareTransition(for route: HomeRoute) -> ViewTransition {
        switch route {
        case let .detail(media):
            let detailViewController = container.resolve(DetailViewController.self, argument: media)!
            detailViewController.modalPresentationStyle = .fullScreen

            return .present(detailViewController)
        }
    }
}
