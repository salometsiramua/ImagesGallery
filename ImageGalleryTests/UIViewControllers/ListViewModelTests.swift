//
//  ListViewModelTests.swift
//  ImageGalleryTests
//
//  Created by Salome Tsiramua on 3/12/21.
//

import XCTest
@testable import ImageGallery

class ListViewModelTests: XCTestCase {

    func testModelSuccessfulCase() {
        let listener = ListUpdatedListenerMock()
        let exp = expectation(description: "List model fetch succeed")
        
        let model: ListViewModel = ListViewModelService(imagesListFetcher: ImagesListFectherMock(), listUpdatedListener: listener)
        model.fetchList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(listener.downloadFinished)
            XCTAssertFalse(listener.alertShown)
            XCTAssertFalse(listener.collectionViewReloaded)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2)
    }
    
    func testModelErrorCase() {
        let listener = ListUpdatedListenerMock()
        let exp = expectation(description: "List model fetch failed")
        
        let model: ListViewModel = ListViewModelService(imagesListFetcher: ImagesListFectherMock(success: false), listUpdatedListener: listener)
        model.fetchList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(listener.downloadFinished)
            XCTAssertTrue(listener.alertShown)
            XCTAssertFalse(listener.collectionViewReloaded)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2)
    }
    
    func testModelReseting() {
        let listener = ListUpdatedListenerMock()
        let exp = expectation(description: "List model relaoding")
        
        let model: ListViewModel = ListViewModelService(imagesListFetcher: ImagesListFectherMock(success: true), listUpdatedListener: listener)
        XCTAssertTrue(model.imageGallery.isEmpty)
        model.fetchList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(listener.downloadFinished)
            XCTAssertFalse(listener.alertShown)
            XCTAssertFalse(listener.collectionViewReloaded)
            XCTAssertFalse(model.imageGallery.isEmpty)
            model.resetAll()
            XCTAssertTrue(model.imageGallery.isEmpty)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2)
    }
}

class ListUpdatedListenerMock: ListUpdatedListener {
    
    var collectionViewReloaded = false
    var alertShown = false
    var error: Error?
    var downloadFinished = false
    
    func reloadCollectionView(rows: [IndexPath]) {
        collectionViewReloaded = true
    }
    
    func showAlert(with error: Error) {
        alertShown = true
        self.error = error
    }
    
    func downloadDidFinish() {
        downloadFinished = true
    }
}

