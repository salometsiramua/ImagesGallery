//
//  DetailsViewModelTests.swift
//  ImageGalleryTests
//
//  Created by Salome Tsiramua on 3/12/21.
//

import XCTest
@testable import ImageGallery

class DetailsViewModelTests: XCTestCase {

    func testDetailsViewModel() {
        let model = DetailsViewModelService(from: ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 21, id: 12, title: "Das", url: "ir.com", thumbnailUrl: "errs.com")))
        let exp = expectation(description: "fetching details")
        model.fetchDetails { (result) in
            switch result {
            case .success:
                XCTFail()
            case .failure:
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 1)
    }
    
    func testDetailsViewModelSuccess() {
        let model = DetailsViewModelService(from: ImageCollectionViewCellViewModel(imageContent: ImageContent(albumId: 21, id: 12, title: "Das", url: "https://i.stack.imgur.com/GsDIl.jpg", thumbnailUrl: "errs.com")))
        let exp = expectation(description: "fetching details")
        model.fetchDetails { (result) in
            switch result {
            case .success(let image):
                XCTAssertNotNil(image)
                exp.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        wait(for: [exp], timeout: 3)
    }
}
