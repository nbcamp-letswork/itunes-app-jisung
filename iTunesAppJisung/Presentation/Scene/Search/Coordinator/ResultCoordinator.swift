import XCoordinator

final class ResultCoordinator: ViewCoordinator<ResultRoute> {
    override func prepareTransition(for route: ResultRoute) -> ViewTransition {
        switch route {
        case let .remaining(title, numberOfItems, itemProvider):
            let resultRemainingViewController = ResultRemainingViewController()
            resultRemainingViewController.modalPresentationStyle = .fullScreen

            resultRemainingViewController.updateUI(
                title: title,
                numberOfItems: numberOfItems,
                itemProvider: itemProvider
            )

            return .present(resultRemainingViewController)
        }
    }
}
