//
//  ListFetcherTests.swift
//  ImageGalleryTests
//
//  Created by Salome Tsiramua on 3/12/21.
//

import XCTest
@testable import ImageGallery

class ListFetcherTests: XCTestCase {

    func testService() {
        let service = ImagesListFetcherService(session: ListFetherServiceSessionMock())
        let exp = expectation(description: "List fetcher succeed")
        
        service.fetch { (result) in
            exp.fulfill()
            switch result {
            case .success(let response):
                XCTAssertNotNil(response.imageContentList)
            case .failure:
                XCTFail()
            }
        }
        
        wait(for: [exp], timeout: 1)
    }

}
