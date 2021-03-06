//
//  PhotosServices.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import Foundation

protocol PhotoServiceType: AnyObject {
    func getPhotos(completion: @escaping RequestResultable<[APIPhoto]>)
    func downloadPhoto(from urlPath: String, completion: @escaping (Result<String, Error>) -> Void)
}

final class PhotosServices: WebService, PhotoServiceType {
    
    private let fileManager: FileProvider
    
    init(baseUrlProvider: BaseURLProviderType, client: WebClientType, fileManager: FileProvider = FileManager.default) {
        self.fileManager = fileManager
        super.init(baseUrlProvider: baseUrlProvider, client: client)
    }
    
    func getPhotos(completion: @escaping RequestResultable<[APIPhoto]>) {
        let endpoint = APIEndpoint(baseUrl: baseUrl.baseURL, path: "/photos")
        let request = APIRequest<[APIPhoto]>(endpoint: endpoint)
        client.loadAPIRequest(request: request, completion: completion)
    }
    
    func downloadPhoto(from urlPath: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: urlPath) else { return }
        
        let fileCachePath = fileManager
            .temporaryDirectory
            .appendingPathComponent(url.pathComponents.dropFirst().joined(separator: "_"), isDirectory: false)
        
        if fileManager.fileExists(atPath: fileCachePath.path) {
            completion(.success(fileCachePath.path))
            return
        }
        
        client.downloadImage(from: url) { [weak fileManager] result in
            switch result {
            case .success(let temporalURL):
                guard let strongFileManager = fileManager else { return }
                do {
                    if strongFileManager.fileExists(atPath: fileCachePath.path) {
                        try strongFileManager.removeItem(at: fileCachePath)
                    }
                    
                    try strongFileManager.copyItem(at: temporalURL, to: fileCachePath)
                    
                    completion(.success(fileCachePath.path))
                    
                } catch let fileError {
                    completion(.failure(fileError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}

protocol FileProvider: AnyObject {
    var temporaryDirectory: URL { get }
    func fileExists(atPath path: String) -> Bool
    func removeItem(at URL: URL) throws
    func copyItem(at srcURL: URL, to dstURL: URL) throws
}


extension FileManager: FileProvider {
    
}
