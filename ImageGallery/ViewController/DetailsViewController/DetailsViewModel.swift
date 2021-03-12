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
        
        guard Reachability.isConnectedToNetwork else {
            return completion(.failure(NetworkError.noInternetConnection))
        }
        
        let downloader = ImageDownloader(Image(url: url), indexPath: nil)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                completion(.failure(NetworkError.couldNotLoadImage))
                return
            }
            
            DispatchQueue.main.async {
                guard downloader.image.state == .downloaded else {
                    completion(.failure(NetworkError.couldNotLoadImage))
                    return
                }
                completion(.success(downloader.image.image))
            }
        }
        downloader.start()
    }
}
