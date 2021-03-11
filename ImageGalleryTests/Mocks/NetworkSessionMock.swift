//
//  NetworkSessionMock.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation
@testable import ImageGallery

struct NetworkSessionMock: NetworkSession {
    
    let success: Bool
    
    init(success: Bool = true) {
        self.success = success
    }
    
    var mockData: DataTaskMock = DataTaskMock()
    
    func dataTask(with url: URLRequest, completionHandler: @escaping HTTPRequestSessionCompletion) -> URLSessionDataTask {
        
        if !success {
            completionHandler(nil, mockData.response, NetworkError.responseDataIsNil)
        }
        
        return mockData
    }
    
}
