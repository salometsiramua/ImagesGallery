//
//  HTTPManagerService.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation

protocol HTTPManagerService {
    
    associatedtype ResponseObject
    
    typealias ServiceSuccessCallback = ((ResponseObject) -> Void)
    typealias ServiceFailureCallback = ((Error) -> Void)
    
    func onSuccess(_ callback: @escaping ServiceSuccessCallback) -> Self
    func onFail(_ callback: @escaping ServiceFailureCallback) -> Self
    
}
