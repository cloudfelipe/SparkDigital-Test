//
//  APIPhoto.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import Foundation

protocol APIResponse: Decodable { }

struct APIPhoto: APIResponse {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}
