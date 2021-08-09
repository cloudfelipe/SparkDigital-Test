//
//  PhotosListViewModel.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import Foundation

protocol PhotoListViewModelType {
    func viewDidLoad()
}

final class PhotoListViewModelImplementation: PhotoListViewModelType {
    
    struct InputDependencies {
        let photosGettable: PhotosGettable
    }
    
    private let dependencies: InputDependencies
    
    init(dependencies: InputDependencies) {
        self.dependencies = dependencies
    }
    
    func viewDidLoad() {
        getPhotos()
    }
    
    private func getPhotos() {
        dependencies.photosGettable.photos { [weak self] result in
            switch result {
            case .success(let photos):
                self?.process(photos: photos)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    private func process(photos: [APIPhoto]) {
        debugPrint(photos)
    }
}
