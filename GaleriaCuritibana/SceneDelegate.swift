// SceneDelegate.swift
// GaleriaCuritibana
//
// Configura a UIWindow e define o rootViewController via View Code,
// sem depender de Main.storyboard.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Instancia o controller principal embrulhado em NavigationController
        let galeriaVC = GaleriaViewController()
        let navController = UINavigationController(rootViewController: galeriaVC)

        // Personaliza a aparência global da NavigationBar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.label
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .systemBrown

        // Configura a janela principal
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
    }
}
