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
        
        let client = WebClient()
        let photoService = PhotosServices(baseUrlProvider: BaseURL(), client: client)
        let photosInteractor = GetPhotosInteractor(service: photoService)
        let imageDownloader = ImageDownloaderInteractor(service: photoService)
        
        let dependencies = AppCoordinator.InputDependencies(photosGettable: photosInteractor, imageDownloader: imageDownloader)
        let appCoordinator = AppCoordinator(router: rootNavigationVC, dependencies: dependencies)
        appCoordinator.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNavigationVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

struct BaseURL: BaseURLProviderType {
    var baseURL: String = "https://jsonplaceholder.typicode.com"
}
