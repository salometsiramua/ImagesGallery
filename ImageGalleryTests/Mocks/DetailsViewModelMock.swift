//
//  DetailsViewModelMock.swift
//  ImageGalleryTests
//
//  Created by Salome Tsiramua on 3/12/21.
//

import UIKit
@testable import ImageGallery

class DetailsViewModelMock: DetailsViewModel {
    
    var isSuccessFul: Bool
    
    init(success: Bool = true) {
        isSuccessFul = success
    }
    
    func fetchDetails(completion: @escaping (Result<UIImage?, Error>) -> Void) {
        if isSuccessFul {
            completion(.success(UIImage()))
        } else {
            completion(.failure(NetworkError.generalError))
        }
    }
}
