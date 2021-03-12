//
//  ImagesListFetcherMock.swift
//  ImageGalleryTests
//
//  Created by Salome Tsiramua on 3/12/21.
//

import Foundation
@testable import ImageGallery

class ImagesListFectherMock: ImagesListFetcher {
    
    var isSuccessFull: Bool
    
    init(success: Bool = true) {
        isSuccessFull = success
    }
    
    func fetch(completion: @escaping (Result<ImageContentListResponse, Error>) -> Void) {
        if isSuccessFull {
            completion(.success(ImageContentListResponse(imageContentList: [ImageContent(albumId: 23,  url: "url.com", thumbnailUrl: "dasd.com"), ImageContent(albumId: 23, url: "url.com", thumbnailUrl: "dasd.com"), ImageContent(albumId: 23, url: "url.com", thumbnailUrl: "dasd.com"), ImageContent(albumId: 23, url: "url.com", thumbnailUrl: "dasd.com"), ImageContent(albumId: 23, url: "url.com", thumbnailUrl: "dasd.com"), ImageContent(albumId: 23, url: "url.com", thumbnailUrl: "dasd.com"), ImageContent(albumId: 23, url: "url.com", thumbnailUrl: "dasd.com"), ImageContent(albumId: 23, url: "url.com", thumbnailUrl: "dasd.com")])))
        } else {
            completion(.failure(NetworkError.generalError))
        }
    }
    
}
