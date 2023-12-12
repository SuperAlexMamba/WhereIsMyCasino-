//
//  AppDelegate.swift
//  1
//
//  Created by Слава Орлов on 27.11.2023.
//

import UIKit
import FirebaseCore
import OneSignalFramework

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
          OneSignal.Debug.setLogLevel(.LL_VERBOSE)
          
          OneSignal.initialize("90019e9a-651f-4533-9c68-8866a0e4b678", withLaunchOptions: launchOptions)
          
          OneSignal.Notifications.requestPermission({ accepted in
            print("User accepted notifications: \(accepted)")
          }, fallbackToSettings: true)
          
        
        return true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
}

