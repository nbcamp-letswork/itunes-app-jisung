import RxSwift
import XCoordinator

final class HomeCoordinator: NavigationCoordinator<HomeRoute> {
    private let disposeBag = DisposeBag()

    private let homeViewController: HomeViewController

    init(homeViewController: HomeViewController) {
        self.homeViewController = homeViewController

        super.init(initialRoute: .home)
    }

    override func prepareTransition(for route: HomeRoute) -> NavigationTransition {
        switch route {
        case .home:
            return .set([homeViewController])
        }
    }
}
