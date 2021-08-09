//
//  APIEndpoint.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

public protocol APIEndpointType {
    var baseUrl: String { get }
    var path: String { get }
}

struct APIEndpoint: APIEndpointType {
    var baseUrl: String
    var path: String
}
