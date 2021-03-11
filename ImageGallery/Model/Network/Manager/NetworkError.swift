//
//  NetworkError.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation

enum NetworkError: Error, Equatable {
    case responseDataIsNil
    case urlIsInvalid
    case generalError
    case noInternetConnection
    case couldNotLoadImage
}

