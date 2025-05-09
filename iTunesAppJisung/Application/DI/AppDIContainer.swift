import Swinject

final class AppDIContainer {
    let container: Container

    init() {
        container = Container()

        registerDataDependencies()
        registerDomainDependencies()
        registerPresentationDependencies()
    }

    private func registerDataDependencies() {
        container.register(FetchMediaDataSource.self) { _ in
            FetchMediaDataSource()
        }

        container.register(MediaRepository.self) { resolver in
            let dataSource = resolver.resolve(FetchMediaDataSource.self)!

            return DefaultMediaRepository(fetchMediaDataSource: dataSource)
        }
    }

    private func registerDomainDependencies() {
        container.register(FetchMediaUseCase.self) { resolver in
            let mediaRepository = resolver.resolve(MediaRepository.self)!

            return DefaultFetchMediaUseCase(mediaRepository: mediaRepository)
        }
    }

    private func registerPresentationDependencies() {
        container.register(MainViewController.self) { _ in
            MainViewController()
        }
        .inObjectScope(.container)

        container.register(MainCoordinator.self) { resolver in
            let mainViewController = resolver.resolve(MainViewController.self)!
            let homeViewController = resolver.resolve(HomeViewController.self)!

            return MainCoordinator(mainViewController: mainViewController, homeViewController: homeViewController)
        }
        .inObjectScope(.container)

        container.register(HomeViewModel.self) { resolver in
            let useCase = resolver.resolve(FetchMediaUseCase.self)!

            return HomeViewModel(fetchMediaUseCase: useCase)
        }
        .inObjectScope(.container)

        container.register(HomeViewController.self) { resolver in
            let viewModel = resolver.resolve(HomeViewModel.self)!

            return HomeViewController(homeViewModel: viewModel)
        }
        .inObjectScope(.container)
    }
}
