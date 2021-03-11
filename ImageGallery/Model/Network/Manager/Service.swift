//
//  Service.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation

enum Service {
    case imageGalleryList
}

extension Service: Endpoint {
    
    var baseUrl: URL? {
        switch self {
        case .imageGalleryList:
            return URL(string: "https://jsonplaceholder.typicode.com/")
        }
    }
    
    var path: String {
        switch self {
        case .imageGalleryList:
            return "photos"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .imageGalleryList:
            return .get
        }
    }
    
}

