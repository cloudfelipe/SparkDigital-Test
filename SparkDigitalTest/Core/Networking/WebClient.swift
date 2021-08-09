//
//  WebClient.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import Foundation

typealias RequestResultable<T: Decodable> = (Result<T, WebClientError>) -> Void

protocol WebClientType {
    func loadAPIRequest<T: APIRequestType>(request: T, completion: @escaping RequestResultable<T.ResponseDataType>)
}

final class WebClient: WebClientType {
    
    let urlSession: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func loadAPIRequest<T: APIRequestType>(request: T, completion: @escaping RequestResultable<T.ResponseDataType>) {
        do {
            let urlRequest = try request.request()
            urlSession.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1000
                    if statusCode == 200 {
                        do {
                            let object = try request.parseResponse(data: data)
                            completion(.success(object))
                        } catch let error {
                            switch error {
                            case is DecodingError:
                                completion(.failure(.decodableError(error: error as! DecodingError)))
                            default:
                                completion(.failure(.unableToParseDataToJSON(reason: error.localizedDescription)))
                            }
                        }
                    } else {
                        completion(.failure(.errorWithCode(statusCode)))
                    }
                } else {
                    completion(.failure(.noDataResponse))
                }
            }.resume()
        } catch {
            completion(.failure(.noDataResponse))
        }
    }
}
