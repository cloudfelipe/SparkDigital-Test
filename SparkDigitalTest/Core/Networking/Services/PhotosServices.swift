//
//  PhotosServices.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

protocol PhotoServiceType {
    func getPhotos(completion: @escaping RequestResultable<[APIPhoto]>)
}

final class PhotosServices: WebService {
    func getPhotos(completion: @escaping RequestResultable<[APIPhoto]>) {
        let endpoint = APIEndpoint(baseUrl: baseUrl.baseURL, path: "/photos")
        let request = APIRequest<[APIPhoto]>(endpoint: endpoint)
        client.loadAPIRequest(request: request, completion: completion)
    }
}
