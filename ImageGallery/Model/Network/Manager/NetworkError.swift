//
//  NetworkError.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation

enum NetworkError: Error, Equatable {
    case responseIsNil
    case responseDataIsNil
    case invalidStatusCode
    case responseParsingToJsonDictionary
    case urlIsInvalid
    case noInternetConnection
}

