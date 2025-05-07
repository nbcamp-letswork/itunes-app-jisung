import Swinject

final class AppDIContainer {
    let container: Container

    init() {
        container = Container()

        registerDependencies()
    }

    private func registerDependencies() {}
}
