//
//  HTTPRequestMock.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation
@testable import ImageGallery

struct HTTPRequestMock: HTTPRequest {
    
    var urlRequest: URLRequest {
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
    
    private var urlString: String
    
    init(urlString: String = "localhost.com/tests") {
        self.urlString = urlString
    }
    
}

