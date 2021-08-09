//
//  APIRequest.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import Foundation

protocol APIRequestType {
    associatedtype ResponseDataType
    
    var endpoint: APIEndpointType { get }
    
    func request() throws -> URLRequest
    func parseResponse(data: Data) throws -> ResponseDataType
}

struct APIRequest<ResponseDataType: Decodable>: APIRequestType {
    
    let endpoint: APIEndpointType
    
    func request() throws -> URLRequest {
        return try URLRequest(endpoint: endpoint)
    }

    func parseResponse(data: Data) throws -> ResponseDataType {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(ResponseDataType.self, from: data)
    }
}
