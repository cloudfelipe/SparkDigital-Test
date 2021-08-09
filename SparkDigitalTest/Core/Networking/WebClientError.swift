//
//  WebClientError.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

enum WebClientError: Error {
    case noInternetConnection
    case urlMalformed(url: String)
    case unableToParseDataToJSON(reason: String?)
    case unableToParseJSONToData(reason: String?)
    case undefined(reason: String?)
    case decodableError(error: DecodingError)
    case noDataResponse
    case errorWithCode(Int)
}
