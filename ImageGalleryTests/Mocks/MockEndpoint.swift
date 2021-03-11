//
//  MockEndpoint.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation
@testable import ImageGallery

struct MockEndpoint: Endpoint {
    
    var baseUrl: URL?
    
    var path: String
    
    var httpMethod: HTTPMethod
    
    init(baseUrl: URL = URL(string: "github.com/tests/")!, path: String = "/testMock", httpMethod: HTTPMethod = .get) {
        self.baseUrl = baseUrl
        self.path = path
        self.httpMethod = httpMethod
    }

}
