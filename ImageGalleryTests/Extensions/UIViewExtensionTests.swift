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
    
    func testPinToParent() {
        let view = UIView()
        let subview = UIView()
        view.addSubview(subview)
        subview.pin(to: view)
        XCTAssertEqual(view.constraints.count, 4)
    }
    
    func testPinToParentLeading() {
        let view = UIView()
        let subview = UIView()
        view.addSubview(subview)
        subview.pin(to: view, directions: [.leading, .top, .bottom])
        XCTAssertEqual(view.constraints.count, 4)
    }

}
