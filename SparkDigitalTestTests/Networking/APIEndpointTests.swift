//
//  APIEndpointTests.swift
//  SparkDigitalTestTests
//
//  Created by Felipe Correa on 8/08/21.
//

import XCTest

final class RESTEndpointTests: XCTestCase {
    
    struct RequestDataStub: Codable {
        let param1: String
        let param2: Double
        let param3: Bool?
    }
    
    func testAPIEndpoint_whenCreatedWithBaseURLAndPath_thenEnableToReturnProperties() throws {
        
        let endpoint = APIEndpoint(
            baseUrl: "http://example.com",
            path: "sample")
        
        XCTAssertEqual(endpoint.baseUrl, "http://example.com")
        XCTAssertEqual(endpoint.path, "sample")
    }
}
