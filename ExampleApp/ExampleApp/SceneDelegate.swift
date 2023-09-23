//
//  SceneDelegate.swift
//  ExampleApp
//
//  Created by Vlad Birukov on 2023-09-23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let factory = SearchFactory()
            window.rootViewController = factory.makeSearchViewController()
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

