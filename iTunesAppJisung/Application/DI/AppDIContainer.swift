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
        .inObjectScope(.container)
    }

    private func registerPresentationDependencies() {
        container.register(MainViewController.self) { resolver in
            let suggestionViewController = resolver.resolve(SuggestionViewController.self)!

            return MainViewController(suggestionViewController: suggestionViewController)
        }
        .inObjectScope(.container)

        container.register(MainCoordinator.self) { resolver in
            let mainViewController = resolver.resolve(MainViewController.self)!
            let homeViewController = resolver.resolve(HomeViewController.self)!
            let suggestionViewController = resolver.resolve(SuggestionViewController.self)!

            return MainCoordinator(
                mainViewController: mainViewController,
                homeViewController: homeViewController,
                suggestionViewController: suggestionViewController
            )
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

        container.register(SearchViewModel.self) { resolver in
            let useCase = resolver.resolve(FetchMediaUseCase.self)!

            return SearchViewModel(fetchMediaUseCase: useCase)
        }
        .inObjectScope(.container)

        container.register(SuggestionViewController.self) { resolver in
            let viewModel = resolver.resolve(SearchViewModel.self)!

            return SuggestionViewController(searchViewModel: viewModel)
        }
        .inObjectScope(.container)
    }
}
