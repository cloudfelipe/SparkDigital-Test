//
//  PhotoListViewModelTests.swift
//  SparkDigitalTestTests
//
//  Created by Felipe Correa on 9/08/21.
//

import XCTest
import RxSwift
import RxBlocking

final class PhotoListViewModelTests: XCTestCase {
    
    final class CoordinatorSpy: AppCoordinatorType {
        var showPhotoDetailCalled: Bool = false
        
        func showPhotoDetail(_ photo: APIPhoto) {
            showPhotoDetailCalled = true
        }
    }
    
    final class PhotoGetStub: PhotosGettable {
        var callback: (() -> Result<[APIPhoto], WebClientError>)!
        func photos(completion: @escaping RequestResultable<[APIPhoto]>) {
            completion(callback())
        }
    }
    
    final class PhotoDownloaderStub: ImageDownloadable {
        
        var callback: (() -> Observable<String>)!
        
        func download(from path: String) -> Observable<String> {
            callback()
        }
    }
    
    var sut: PhotoListViewModelImplementation!
    var coordinator: CoordinatorSpy!
    var photosGetStub: PhotoGetStub!
    var imageDown: PhotoDownloaderStub!
    
    override func setUp() {
        super.setUp()
        coordinator = CoordinatorSpy()
        photosGetStub = PhotoGetStub()
        imageDown = PhotoDownloaderStub()
        let dep = PhotoListViewModelImplementation.InputDependencies(coordinator: coordinator, photosGettable: photosGetStub, imageDownloader: imageDown)
        sut = PhotoListViewModelImplementation(dependencies: dep)
    }
    
    func testGetPhotos() throws {
        
        photosGetStub.callback = {
            return .success([APIPhoto(albumId: 1,
                                      id: 1, title: "Title",
                                      url: "sample.com/1",
                                      thumbnailUrl: "sample.com/2")])
        }
        
        imageDown.callback = {
            return .just("fileLocalPath")
        }
        
        sut.getPhotos()
        
        let viewData = try sut.photos.toBlocking().first()
        
        XCTAssertEqual(viewData?.first?.name, "Title")
        XCTAssertEqual(try viewData?.first?.thumbnail.toBlocking().first(), "fileLocalPath")
    }
    
    func testShowDetail() {
        photosGetStub.callback = {
            return .success([APIPhoto(albumId: 1,
                                      id: 1, title: "Title",
                                      url: "sample.com/1",
                                      thumbnailUrl: "sample.com/2")])
        }
        
        imageDown.callback = {
            return .just("fileLocalPath")
        }
        
        sut.getPhotos()
        
        sut.photoSelected(at: 0)
        
        XCTAssertTrue(coordinator.showPhotoDetailCalled)
        
    }
}
