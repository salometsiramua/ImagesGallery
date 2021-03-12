//
//  TestConstants.swift
//  ImageGalleryTests
//
//  Created by Salome Tsiramua on 3/12/21.
//

import XCTest
@testable import ImageGallery

class TestConstants: XCTestCase {

    func testSizes() {
        XCTAssertEqual(Constants.Size.cell.value, 100)
        XCTAssertEqual(Constants.Size.sectionHeader.value, 40)
    }
    
    func testSpacing() {
        XCTAssertEqual(Constants.Spacing.margin.value, 30)
        XCTAssertEqual(Constants.Spacing.padding.value, 10)
    }
    
}
