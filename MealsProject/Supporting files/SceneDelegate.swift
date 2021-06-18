//
//  SceneDelegate.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 12.06.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.windowScene = windowScene
        let controller = LoginScreenAssembly().build()
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        try? CoreDataStorage.instance.container.viewContext.save()
    }
}
