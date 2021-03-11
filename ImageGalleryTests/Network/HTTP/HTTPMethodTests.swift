//
//  HTTPMethodTests.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import XCTest
@testable import Pokemon

class HTTPMethodTests: XCTestCase {

    func testRawValues() {
      
        XCTAssertEqual(HTTPMethod.get.rawValue, "GET")
    }
}
