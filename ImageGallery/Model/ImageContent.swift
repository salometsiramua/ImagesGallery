//
//  ImageContent.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation

struct ImageContentListResponse {
    var imageContentList: [ImageContent]
}

extension ImageContentListResponse: MappableResponse {
    init(data: Data) throws {
        imageContentList = try JSONDecoder().decode(Array<ImageContent>.self, from: data)
    }
}

struct ImageContent: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
