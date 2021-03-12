//
//  DetailsViewControllerTests.swift
//  ImageGalleryTests
//
//  Created by Salome Tsiramua on 3/12/21.
//

import XCTest
@testable import ImageGallery

class DetailsViewControllerTests: XCTestCase {

    func initViewController() -> DetailsViewController {
        let viewController = Storyboard.details.value.instantiateInitialViewController() as? DetailsViewController
        UIWindow().addSubview(viewController!.view)
        return viewController!
    }

    func testInit() {
        let viewController = initViewController()
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController.view)
    }
    
    func testDetailsViewControllerWithMockModel() {
        let viewController = initViewController()
        viewController.viewModel = DetailsViewModelMock()
        XCTAssertNil(viewController.detailedImageView.image)
        viewController.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(viewController.detailedImageView.image)
        }
    }
    
}
