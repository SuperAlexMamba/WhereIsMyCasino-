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
                
        let window = UIWindow(windowScene: windowScene)
        
        Initialize.shared.loadControllers(in: window)
        
        self.window = window
        
        Orientation.lockOrientation(.all)
        
        window.makeKeyAndVisible()
    }
    
}

