//
//  PhotoDetailViewModel.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 9/08/21.
//

import Foundation
import RxSwift
import RxRelay

protocol PhotoDetailViewModelType: AnyObject {
    var disposeBag: DisposeBag { get }
    var photoImagePath: Observable<String> { get }
    var dataRequestState: Observable<DataRequestState> { get }
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
    
    var dataRequestState: Observable<DataRequestState> {
        return requestState.asObservable()
    }
    private let requestState = BehaviorRelay<DataRequestState>(value: .normal)
    private let photoImage = BehaviorRelay<String>(value: "")
    private let dependencies: InputDependencies
    
    init(dependencies: InputDependencies) {
        self.dependencies = dependencies
    }
    
    func viewDidLoad() {
        requestState.accept(.downloading)
        dependencies
            .imageDownloader
            .download(from: dependencies.photo.url)
            .subscribe(onNext: { [weak self] imagePath in
                self?.photoImage.accept(imagePath)
                self?.requestState.accept(.normal)
            }, onError: { [weak self] error in
                self?.requestState.accept(.error)
            })
            .disposed(by: disposeBag)
    }
}
