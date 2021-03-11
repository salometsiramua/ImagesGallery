//
//  HTTPRequestSession.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation

public typealias HTTPRequestSessionCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol HTTPRequestSession: class {
    func request(_ request: HTTPRequest, completion: @escaping HTTPRequestSessionCompletion)
    func cancel()
}
