//
//  DetailsViewModel.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import UIKit

protocol DetailsViewModel {
    func fetchDetails(completion: @escaping (Result<UIImage?, Error>) -> Void)
}

class DetailsViewModelService: DetailsViewModel {
    
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    private let url: String
    
    init(from model: ImageCollectionViewCellViewModel) {
        url = model.url
    }
    
    func fetchDetails(completion: @escaping (Result<UIImage?, Error>) -> Void) {
        
        utilityQueue.async { [weak self] in
            guard let self = self else {
                completion(.failure(NetworkError.generalError))
                return
            }
            guard let url = URL(string: self.url), let data = try? Data(contentsOf: url) else {
                completion(.failure(NetworkError.couldNotLoadImage))
                return
            }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        
    }
}
