import Swinject
import XCoordinator

final class ResultRemainingCoordinator: ViewCoordinator<ResultRemainingRoute> {
    private let container: Swinject.Container

    init(
        rootViewController: ResultRemainingViewController,
        container: Swinject.Container
    ) {
        self.container = container

        super.init(rootViewController: rootViewController)

        rootViewController.router = weakRouter
    }

    override func prepareTransition(for route: ResultRemainingRoute) -> ViewTransition {
        switch route {
        case let .detail(media):
            let detailViewController = container.resolve(DetailViewController.self, argument: media)!
            detailViewController.modalPresentationStyle = .fullScreen

            return .present(detailViewController)
        }
    }
}
