//
//  ImagesListFetcher.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation

protocol ImagesListFetcher {
    
    func fetch(completion: @escaping (Result<ImageContentListResponse, Error>) -> Void)
}

class ImagesListFetcherService: ImagesListFetcher {
    
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch(completion: @escaping (Result<ImageContentListResponse, Error>) -> Void) {
        
        guard Reachability.isConnectedToNetwork else {
            return completion(.failure(NetworkError.noInternetConnection))
        }
        
        ServiceManager<ImageContentListResponse>(session: self.session, Service.imageGalleryList, onSuccess: { (response) in
            completion(.success(response))
        }) { (error) in
            completion(.failure(error))
        }
    }
}
