//
//  AppCoordinator.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import UIKit

final class AppCoordinator: AppCoordinatorType {
    
    struct InputDependencies {
        let photosGettable: PhotosGettable
        let imageDownloader: ImageDownloadable
    }
    
    private weak var router: UINavigationController?
    private let dependencies: InputDependencies
    
    init(router: UINavigationController, dependencies: InputDependencies) {
        self.router = router
        self.dependencies = dependencies
    }
    
    func start() {
        let inputDependencies = PhotoListViewModelImplementation
            .InputDependencies(coordinator: self,
                               photosGettable: dependencies.photosGettable,
                               imageDownloader: dependencies.imageDownloader)
        let viewModel = PhotoListViewModelImplementation(dependencies: inputDependencies)
        let viewController = PhotoListViewController(viewModel: viewModel)
        router?.pushViewController(viewController, animated: false)
    }
    
    func showPhotoDetail(_ photo: APIPhoto) {
        let dependencies = PhotoDetailViewModelImplementation
            .InputDependencies(photo: photo,
                               imageDownloader: dependencies.imageDownloader)
        let viewModel = PhotoDetailViewModelImplementation(dependencies: dependencies)
        let viewController = PhotoDetailViewController(viewModel: viewModel)
        
        DispatchQueue.main.async { [weak router] in
            router?.pushViewController(viewController)
        }
    }
}
