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
    }
}
