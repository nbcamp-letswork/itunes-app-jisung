import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?
    let appDIContainer = AppDIContainer()

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = UIColor.systemBackground

        let coordinator = appDIContainer.makeMainCoordinator()
        coordinator.setRoot(for: window)

        window.makeKeyAndVisible()

        self.window = window
        self.coordinator = coordinator
    }
}
