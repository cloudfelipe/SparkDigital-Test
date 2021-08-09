//
//  PhotoDetailViewModel.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 9/08/21.
//

import Foundation
import RxSwift

protocol PhotoDetailViewModelType: AnyObject {
    var disposeBag: DisposeBag { get }
    var photoImagePath: Observable<String> { get }
    func viewDidLoad()
}

final class PhotoDetailViewModelImplementation: PhotoDetailViewModelType {
    
    struct InputDependencies {
        let photo: APIPhoto
        let imageDownloader: ImageDownloadable
    }
    
    let disposeBag = DisposeBag()
    
    var photoImagePath: Observable<String> {
        photoImage.asObservable()
    }
    
    private let photoImage = BehaviorSubject<String>(value: "")
    private let dependencies: InputDependencies
    
    init(dependencies: InputDependencies) {
        self.dependencies = dependencies
    }
    
    func viewDidLoad() {
        dependencies.imageDownloader.download(from: dependencies.photo.url)
            .bind(to: photoImage)
            .disposed(by: disposeBag)
    }
}
