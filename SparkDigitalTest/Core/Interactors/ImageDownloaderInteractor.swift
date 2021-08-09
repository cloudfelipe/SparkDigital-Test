//
//  ImageDownloaderInteractor.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 9/08/21.
//

import RxSwift

protocol ImageDownloadable {
    func download(from path: String) -> Observable<String>
}

final class ImageDownloaderInteractor: ImageDownloadable {
    private let service: PhotoServiceType
    
    init(service: PhotoServiceType) {
        self.service = service
    }
    
    func download(from path: String) -> Observable<String> {
        return .create { [weak service] observer in
            service?.downloadPhoto(from: path) { result in
                switch result {
                case .failure(let error):
                    observer.onError(error)
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}
