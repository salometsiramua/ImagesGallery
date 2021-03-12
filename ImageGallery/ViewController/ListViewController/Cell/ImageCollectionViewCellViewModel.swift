//
//  ImageCollectionViewCellViewModel.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation

struct ImageCollectionViewCellViewModel {
    let url: String
    let thumbnailUrl: String
    var image: Image
    
    init(imageContent: ImageContent) {
        url = imageContent.url
        thumbnailUrl = imageContent.thumbnailUrl
        image = Image(url: thumbnailUrl)
    }
}
