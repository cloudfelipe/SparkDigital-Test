//
//  PhotosListViewModel.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import Foundation
import RxSwift
import RxCocoa

enum DataRequestState {
    case loading
    case error
    case normal
    case downloading
    case downloadedFile
}

protocol PhotoListViewModelType: AnyObject {
    var disposeBag: DisposeBag { get }
    var photos: Observable<[PhotoListViewData]> { get }
    var dataRequestState: Observable<DataRequestState> { get }
    func photoSelected(at index: Int)
    func viewDidLoad()
}

final class PhotoListViewModelImplementation: PhotoListViewModelType {
    
    struct InputDependencies {
        let coordinator: AppCoordinatorType
        let photosGettable: PhotosGettable
        let imageDownloader: ImageDownloadable
    }
    
    private let dependencies: InputDependencies
    let disposeBag = DisposeBag()
    
    var photos: Observable<[PhotoListViewData]> {
        photosRelay.asObservable()
    }
    
    var dataRequestState: Observable<DataRequestState> {
        return requestState.asObservable()
    }
    private let requestState = BehaviorRelay<DataRequestState>(value: .normal)
    
    private var photosRelay = BehaviorRelay<[PhotoListViewData]>(value: [])
    private var apiPhotos = [APIPhoto]()
    
    init(dependencies: InputDependencies) {
        self.dependencies = dependencies
    }
    
    func viewDidLoad() {
        getPhotos()
    }
    
    private func getPhotos() {
        requestState.accept(.loading)
        dependencies.photosGettable.photos { [weak self] result in
            switch result {
            case .success(let photos):
                self?.apiPhotos = photos
                self?.requestState.accept(.normal)
                self?.process(photos: photos)
            case .failure(let error):
                debugPrint(error)
                self?.requestState.accept(.error)
            }
        }
    }
    
    private func process(photos: [APIPhoto]) {
        let listData = photos.map { apiPhoto in
            PhotoListViewData(name: apiPhoto.title, thumbnail: self.dependencies.imageDownloader.download(from: apiPhoto.thumbnailUrl)) }
        photosRelay.accept(listData)
    }
    
    func photoSelected(at index: Int) {
        dependencies.coordinator.showPhotoDetail(apiPhotos[index])
    }
}

struct PhotoListViewData {
    let name: String
    let thumbnail: Observable<String>
}
