//
//  SceneDelegate.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 18.06.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let rootViewController = MyBudgetDependencyContainer(sharedWindow: window!).makeMainViewController()
        window?.rootViewController = rootViewController
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
    }
    
}
