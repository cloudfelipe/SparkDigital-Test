//
//  AppDelegate.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var rootNavigationVC: UINavigationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        rootNavigationVC = UINavigationController()
        
        let appCoordinator = AppCoordinator(router: rootNavigationVC)
        appCoordinator.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNavigationVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

