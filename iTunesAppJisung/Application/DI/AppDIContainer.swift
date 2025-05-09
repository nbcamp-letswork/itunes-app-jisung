import Swinject

final class AppDIContainer {
    let container: Container

    init() {
        container = Container()

        registerHomeDependencies()
    }

    private func registerHomeDependencies() {
        container.register(FetchMusicDataSource.self) { _ in
            FetchMusicDataSource()
        }

        container.register(MusicRepository.self) { resolver in
            let dataSource = resolver.resolve(FetchMusicDataSource.self)!

            return DefaultMusicRepository(fetchMusicDataSource: dataSource)
        }

        container.register(FetchMusicUseCase.self) { resolver in
            let musicRepository = resolver.resolve(MusicRepository.self)!

            return DefaultFetchMusicUseCase(musicRepository: musicRepository)
        }

        container.register(HomeViewModel.self) { resolver in
            let useCase = resolver.resolve(FetchMusicUseCase.self)!

            return HomeViewModel(fetchMusicUseCase: useCase)
        }
        .inObjectScope(.container)

        container.register(HomeViewController.self) { resolver in
            let viewModel = resolver.resolve(HomeViewModel.self)!

            return HomeViewController(homeViewModel: viewModel)
        }

        container.register(HomeCoordinator.self) { resolver in
            let viewController = resolver.resolve(HomeViewController.self)!

            return HomeCoordinator(homeViewController: viewController)
        }
    }
}
