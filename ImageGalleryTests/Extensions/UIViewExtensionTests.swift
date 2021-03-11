//
//  UIViewExtensionTests.swift
//  ImageGalleryTests
//
//  Created by Salome Tsiramua on 3/11/21.
//

import XCTest
@testable import ImageGallery

class UIViewExtensionTests: XCTestCase {

    func testIdentifier() {
        XCTAssertEqual(ImageCollectionViewCell.identifier, "ImageCollectionViewCell")
        XCTAssertEqual(UIView.identifier, "UIView")
    }

}
