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

        container.register(RSSFeedParser.self) { _ in
            RSSFeedParser()
        }

        container.register(FeedURLRepository.self) { resolver in
            let parser = resolver.resolve(RSSFeedParser.self)!

            return DefaultFeedURLRepository(rssFeedParser: parser)
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

        container.register(ParseFeedURLUseCase.self) { resolver in
            let feedURLRepository = resolver.resolve(FeedURLRepository.self)!

            return DefaultParseFeedURLUseCase(feedURLRepository: feedURLRepository)
        }
        .inObjectScope(.container)
    }

    private func registerPresentationDependencies() {
        container.register(MainViewController.self) { _ in
            MainViewController()
        }
        .inObjectScope(.container)

        container.register(MainCoordinator.self) { resolver in
            let mainViewController = resolver.resolve(MainViewController.self)!
            let homeViewController = resolver.resolve(HomeViewController.self)!
            let searchViewModel = resolver.resolve(SearchViewModel.self)!

            return MainCoordinator(
                mainViewController: mainViewController,
                homeViewController: homeViewController,
                searchViewModel: searchViewModel
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
    }
}
