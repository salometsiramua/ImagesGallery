//
//  ServiceManagerTests.swift
//  ImageGalleryTests
//
//  Created by Salome Tsiramua on 3/11/21.
//

import XCTest
@testable import ImageGallery

class ServiceManagerTests: XCTestCase {

    func testNetworkSessionMock() {
        let sessionMock = NetworkSessionMock()
        
        sessionMock.mockData.resumeHandler = {
            XCTFail()
        }
        
        let mgr = ServiceManager<ImageContentListResponse>(session: sessionMock, MockEndpoint())
        
        XCTAssertFalse(mgr.isRunning)
    }
}
