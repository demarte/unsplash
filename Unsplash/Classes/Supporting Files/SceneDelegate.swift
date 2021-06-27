//
//  SceneDelegate.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var coordinator: MainCoordinator?
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator?.start()

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
