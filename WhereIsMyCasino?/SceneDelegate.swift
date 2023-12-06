//
//  SceneDelegate.swift
//  1
//
//  Created by Слава Орлов on 27.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let loadingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Loading") as! LoadingViewController
        let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        
        let window = UIWindow(windowScene: windowScene)
        
        if UserDefaults.standard.bool(forKey: "loadingViewControllerShown") {
            
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
            
        }
        
        else {
            
            window.rootViewController = loadingViewController
            window.makeKeyAndVisible()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                window.rootViewController = tabBarController
                window.makeKeyAndVisible()
                
            }
        }
        
        self.window = window
    }
}

