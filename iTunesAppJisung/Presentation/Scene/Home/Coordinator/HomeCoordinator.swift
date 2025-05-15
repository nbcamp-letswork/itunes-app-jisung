import XCoordinator

final class HomeCoordinator: ViewCoordinator<HomeRoute> {
    private let detailViewController: DetailViewController

    init(
        mainViewController: MainViewController,
        homeViewController: HomeViewController,
        detailViewController: DetailViewController
    ) {
        self.detailViewController = detailViewController

        super.init(rootViewController: homeViewController)

        homeViewController.delegate = mainViewController
        homeViewController.router = weakRouter
    }

    override func prepareTransition(for route: HomeRoute) -> ViewTransition {
        switch route {
        case let .detail(media):
            detailViewController.modalPresentationStyle = .fullScreen

            detailViewController.updateUI(media: media)

            return .present(detailViewController)
        }
    }
}
