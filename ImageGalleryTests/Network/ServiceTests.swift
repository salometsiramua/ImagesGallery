//
//  ServiceTests.swift
//  ImageGalleryTests
//
//  Created by Salome Tsiramua on 3/11/21.
//

import XCTest
@testable import ImageGallery

class ServiceTests: XCTestCase {
    
    func testListServicePath() {
        let list = Service.imageGalleryList
        XCTAssertEqual(list.path, "photos")
    }
    
    func testListHTTPMethod() {
        let list = Service.imageGalleryList
        XCTAssertEqual(list.httpMethod, .get)
    }
    
    func testListBaseUrl() {
        let list = Service.imageGalleryList
        XCTAssertEqual(list.baseUrl?.absoluteString, "https://jsonplaceholder.typicode.com/")
    }
}
