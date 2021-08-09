//
//  URLRequest+Extensions.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import Foundation

extension URLRequest {
    init(endpoint: APIEndpointType) throws {
        
        guard let apiURL = URL(string: endpoint.baseUrl + endpoint.path) else {
            throw WebClientError.urlMalformed(url: endpoint.baseUrl)
        }
        
        self.init(url: apiURL)
    }
}
