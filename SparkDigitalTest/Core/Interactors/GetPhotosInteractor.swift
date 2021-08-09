//
//  GetPhotosInteractor.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import Foundation

protocol PhotosGettable {
    func photos(completion: @escaping RequestResultable<[APIPhoto]>)
}

final class GetPhotosInteractor: PhotosGettable {
    
    private let service: PhotoServiceType
    
    init(service: PhotoServiceType) {
        self.service = service
    }
    
    func photos(completion: @escaping RequestResultable<[APIPhoto]>) {
        service.getPhotos(completion: completion)
    }
}
