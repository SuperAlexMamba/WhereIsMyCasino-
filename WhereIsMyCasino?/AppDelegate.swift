//
//  AppDelegate.swift
//  1
//
//  Created by Слава Орлов on 27.11.2023.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        
    }
}

