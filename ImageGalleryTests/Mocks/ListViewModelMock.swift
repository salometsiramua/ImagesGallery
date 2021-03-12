//
//  ListViewModelMock.swift
//  ImageGalleryTests
//
//  Created by Salome Tsiramua on 3/12/21.
//

import Foundation
@testable import ImageGallery

class ListViewModelMock: ListViewModel {
    
    var imageGallery: [Int : [ImageCollectionViewCellViewModel]] = [:]
    
    var operationsRunning = false
    
    func fetchList() {
        imageGallery = [2:[ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 2, url: "url.com", thumbnailUrl: "urlsd.com")), ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 2, url: "url.com", thumbnailUrl: "urlsd.com")), ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 2, url: "url.com", thumbnailUrl: "urlsd.com")), ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 2, url: "url.com", thumbnailUrl: "urlsd.com"))],
                                                                        3: [ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 3, url: "url.com", thumbnailUrl: "urlsd.com")), ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 3, url: "url.com", thumbnailUrl: "urlsd.com")), ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 3, url: "url.com", thumbnailUrl: "urlsd.com"))],
                                                                        4: [ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 4, url: "url.com", thumbnailUrl: "urlsd.com")), ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 4, url: "url.com", thumbnailUrl: "urlsd.com")), ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 4, url: "url.com", thumbnailUrl: "urlsd.com"))]]
    }
    
    func suspendAllOperations() {
        operationsRunning = false
    }
    
    func resumeAllOperations() {
        operationsRunning = true
    }
    
    func loadImages(for cells: [IndexPath]?) {
        
    }
    
    func key(for index: Int) -> Int? {
        return 0
    }
    
    func resetAll() {
        imageGallery.removeAll()
    }
}
