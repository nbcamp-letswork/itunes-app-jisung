import Swinject

final class AppDIContainer {
    let container: Container

    init() {
        container = Container()

        registerDataDependencies()
        registerDomainDependencies()
        registerPresentationDependencies()
    }

    func makeMainCoordinator() -> MainCoordinator {
        MainCoordinator(container: container)
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

        container.register(ParseFeedURLUseCase.self) { resolver in
            let feedURLRepository = resolver.resolve(FeedURLRepository.self)!

            return DefaultParseFeedURLUseCase(feedURLRepository: feedURLRepository)
        }
    }

    private func registerPresentationDependencies() {
        container.register(HomeViewModel.self) { resolver in
            let useCase = resolver.resolve(FetchMediaUseCase.self)!

            return HomeViewModel(fetchMediaUseCase: useCase)
        }
        .inObjectScope(.container)

        container.register(SearchViewModel.self) { resolver in
            let useCase = resolver.resolve(FetchMediaUseCase.self)!

            return SearchViewModel(fetchMediaUseCase: useCase)
        }
        .inObjectScope(.container)

        container.register(MainViewController.self) { _ in
            MainViewController()
        }

        container.register(HomeViewController.self) { resolver in
            let viewModel = resolver.resolve(HomeViewModel.self)!

            return HomeViewController(homeViewModel: viewModel)
        }

        container.register(SuggestionViewController.self) { resolver in
            let viewModel = resolver.resolve(SearchViewModel.self)!

            return SuggestionViewController(searchViewModel: viewModel)
        }

        container.register(ResultViewController.self) { resolver in
            let viewModel = resolver.resolve(SearchViewModel.self)!

            return ResultViewController(searchViewModel: viewModel)
        }

        container.register(ResultRemainingViewController.self) { _ in
            ResultRemainingViewController()
        }

        container.register(DetailViewController.self) { _ in
            DetailViewController()
        }
    }
}
