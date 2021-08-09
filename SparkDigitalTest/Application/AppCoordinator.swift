//
//  AppCoordinator.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import UIKit

protocol AppCoordinatorType {
    func showPhotoDetail(_ photo: APIPhoto)
}

final class AppCoordinator: AppCoordinatorType {
    
    private weak var router: UINavigationController?
    
    init(router: UINavigationController) {
        self.router = router
    }
    
    func start() {
        let client = WebClient()
        let photoService = PhotosServices(baseUrlProvider: BaseURL(), client: client)
        let photosInteractor = GetPhotosInteractor(service: photoService)
        let imageDownloader = ImageDownloaderInteractor(service: photoService)
        let inputDependencies = PhotoListViewModelImplementation
            .InputDependencies(coordinator: self, photosGettable: photosInteractor, imageDownloader: imageDownloader)
        let viewModel = PhotoListViewModelImplementation(dependencies: inputDependencies)
        let viewController = PhotoListViewController(viewModel: viewModel)
        router?.pushViewController(viewController, animated: false)
    }
    
    func showPhotoDetail(_ photo: APIPhoto) {
        
    }
}

struct BaseURL: BaseURLProviderType {
    var baseURL: String = "https://jsonplaceholder.typicode.com"
}
