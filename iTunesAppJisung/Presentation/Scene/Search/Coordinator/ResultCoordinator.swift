import Swinject
import XCoordinator

final class ResultCoordinator: ViewCoordinator<ResultRoute> {
    private let container: Swinject.Container
    private var resultRemainingCoordinator: ResultRemainingCoordinator!

    init(
        rootViewController: ResultViewController,
        delegate: MainViewController,
        container: Swinject.Container
    ) {
        self.container = container
        super.init(rootViewController: rootViewController)

        rootViewController.delegate = delegate
        rootViewController.router = weakRouter
    }

    override func prepareTransition(for route: ResultRoute) -> ViewTransition {
        switch route {
        case let .remaining(title, numberOfItems, itemProvider):
            let resultRemainingViewController = container.resolve(ResultRemainingViewController.self)!
            resultRemainingViewController.modalPresentationStyle = .fullScreen
            resultRemainingViewController.updateUI(
                title: title,
                numberOfItems: numberOfItems,
                itemProvider: itemProvider
            )

            resultRemainingCoordinator = ResultRemainingCoordinator(
                rootViewController: resultRemainingViewController,
                container: container
            )

            return .present(resultRemainingViewController)

        case let .detail(media):
            let detailViewController = container.resolve(DetailViewController.self, argument: media)!
            detailViewController.modalPresentationStyle = .fullScreen

            return .present(detailViewController)
        }
    }
}
