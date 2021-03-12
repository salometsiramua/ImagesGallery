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
        imageGallery = [2:[ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 2, id: 1, title: "ds", url: "url.com", thumbnailUrl: "urlsd.com")), ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 2, id: 2, title: "ds", url: "url.com", thumbnailUrl: "urlsd.com")), ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 2, id: 3, title: "ds", url: "url.com", thumbnailUrl: "urlsd.com")), ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 2, id: 4, title: "ds", url: "url.com", thumbnailUrl: "urlsd.com"))],
                                                                        3: [ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 3, id: 5, title: "ds", url: "url.com", thumbnailUrl: "urlsd.com")), ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 3, id: 6, title: "ds", url: "url.com", thumbnailUrl: "urlsd.com")), ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 3, id: 7, title: "ds", url: "url.com", thumbnailUrl: "urlsd.com"))],
                                                                        4: [ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 4, id: 8, title: "ds", url: "url.com", thumbnailUrl: "urlsd.com")), ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 4, id: 9, title: "ds", url: "url.com", thumbnailUrl: "urlsd.com")), ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 4, id: 10, title: "ds", url: "url.com", thumbnailUrl: "urlsd.com"))]]
    }
    
    func suspendAllOperations() {
        operationsRunning = false
    }
    
    func resumeAllOperations() {
        operationsRunning = true
    }
    
    func images(for cells: [IndexPath]?) {
        
    }
    
    func key(for index: Int) -> Int {
        return 0
    }
    
    func resetAll() {
        imageGallery.removeAll()
    }
}
