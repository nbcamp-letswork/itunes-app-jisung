import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: HomeCoordinator?
    let appDIContainer = AppDIContainer()

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = UIColor.systemBackground

        let coordinator = appDIContainer.container.resolve(HomeCoordinator.self)!
        coordinator.setRoot(for: window)
        coordinator.trigger(.home)

        window.makeKeyAndVisible()

        self.window = window
        self.coordinator = coordinator
    }
}
