//
//  WebService.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

class WebService {
    
    internal let client: WebClientType
    internal let baseUrl: BaseURLProviderType
    
    public init(baseUrlProvider: BaseURLProviderType, client: WebClientType) {
        self.client = client
        self.baseUrl = baseUrlProvider
    }
}
