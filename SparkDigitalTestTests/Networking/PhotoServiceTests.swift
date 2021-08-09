//
//  PhotoServiceTests.swift
//  SparkDigitalTestTests
//
//  Created by Felipe Correa on 9/08/21.
//

import XCTest

final class PhotoServiceTests: XCTestCase {
    
    struct URLProviderStub: BaseURLProviderType {
        var baseURL: String = "Sample.com"
    }
    
    final class WebClientStub: WebClientType {
        
        var loadAPICallback: (()->Void)?
        var downLoadImageCallback: ((URL) -> Result<URL, WebClientError>)?
        
        func loadAPIRequest<T>(request: T, completion: @escaping RequestResultable<T.ResponseDataType>) where T : APIRequestType, T.ResponseDataType : Decodable {
            
        }
        
        func downloadImage(from url: URL, completion: @escaping (Result<URL, WebClientError>) -> Void) {
            completion(downLoadImageCallback!(url))
        }
    }
    
    final class FileProviderStub: FileProvider {
        var temporaryDirectory: URL = URL(string: "Sample.com")!
        
        func fileExists(atPath path: String) -> Bool {
            return true
        }
        
        func removeItem(at URL: URL) throws {
        }
        
        func copyItem(at srcURL: URL, to dstURL: URL) throws {
            
        }
    }
    
    var sut: PhotosServices!
    var clientStub: WebClientStub!
    var fileProviderStub: FileProviderStub!
    
    override func setUp() {
        super.setUp()
        clientStub = WebClientStub()
        fileProviderStub = FileProviderStub()
        sut = PhotosServices(baseUrlProvider: URLProviderStub(),
                             client: clientStub, fileManager: fileProviderStub)
    }
    
    func testDownloadImage_whenURLIsProvided_thenResponseURLPath() throws {
        
        clientStub.downLoadImageCallback = { url in
            return .success(self.fileProviderStub.temporaryDirectory)
        }
        
        var finalResult: Result<String, Error>?
        let waitExpectation = expectation(description: "Sut Calling")
        sut.downloadPhoto(from: "https://sample.com/image/1") { result in
            finalResult = result
            waitExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.5, handler: nil)
        
        XCTAssertNotNil(finalResult)
        XCTAssertEqual(try finalResult?.get(), "Sample.com/image_1")
    }
}
