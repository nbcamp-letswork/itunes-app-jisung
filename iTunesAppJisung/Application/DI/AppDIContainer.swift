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
    }
}
