//
//  Endpoint.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation

protocol Endpoint {
    var baseUrl: URL? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
}
