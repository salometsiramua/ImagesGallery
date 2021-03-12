//
//  ListViewControllerTests.swift
//  ImageGalleryTests
//
//  Created by Salome Tsiramua on 3/12/21.
//

import XCTest
@testable import ImageGallery

class ListViewControllerTests: XCTestCase {

    func initViewController() -> ListViewController {
        let viewController = Storyboard.main.value.instantiateInitialViewController() as? ListViewController
        UIWindow().addSubview(viewController!.view)
        return viewController!
    }
    
    func testInit() {
        let viewController = initViewController()
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController.view)
    }

    func testListViewControllerWithMockedModel() {
        let viewController = initViewController()
        viewController.viewModel = ListViewModelMock()
        XCTAssertEqual(viewController.numberOfSections(in: viewController.collectionView), 0)
        viewController.viewDidLoad()
        XCTAssertEqual(viewController.numberOfSections(in: viewController.collectionView), 3)
    }
    
    func testListViewControllerRefreshData() {
        let viewController = initViewController()
        viewController.viewModel = ListViewModelMock()
        viewController.collectionView.refreshControl?.beginRefreshing()
        XCTAssertEqual(viewController.numberOfSections(in: viewController.collectionView), 0)
    }
}
