//
//  HTTPServiceRequest.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation

struct HTTPServiceRequest: HTTPRequest {
    
    let urlRequest: URLRequest
    
    init?(endpoint: Endpoint) {
        
        guard let url = (endpoint.baseUrl.flatMap { URL(string: $0.absoluteString + endpoint.path) }) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue

        if request.value(forHTTPHeaderField: "Content-Type")?.isEmpty != false {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        self.urlRequest = request
                
    }
    
    
}
