//
//  DataTaskMock.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//
//

import Foundation
@testable import ImageGallery

class DataTaskMock: URLSessionDataTask {
    
    var cancelHandler: (()->())?
    var resumeHandler: (()->())?
    
    override func resume() {
        resumeHandler?()
    }
    
    override func cancel() {
        cancelHandler?()
    }
    
    override init() { }
    
}
