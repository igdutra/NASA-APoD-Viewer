//
//  PhotoInfoServicesTests.swift
//  NASA APoD Viewer Tests
//
//  Created by Ivo Dutra on 30/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import XCTest
@testable import NASA_APoD_Viewer

class PhotoInfoServicesTests: XCTestCase {

    var sut: PhotoInfoServices!

    override func setUp() {
        super.setUp()

        sut = PhotoInfoServices()
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    // MARK: - FetchPhotoInfo

    // This method should be tested asynchronously, because it does a web request

    func testFetchPhotoInfoSuccess() {

        // Create an expectation for a background download task
        let expectation = XCTestExpectation(description: "Download photo of the day")
        // Day to perfom the request
        let day = "2020-07-25"
        // Correct photo infos
        let title = "Tianwen-1 Mission to Mars"
        let copyright = "Jeff Dai"

        sut.fetchPhotoInfo(onDay: day) { (info) in
            // Assert that infos match and fulfill expectation
            if let photoInfo = info {
                XCTAssertEqual(title, photoInfo.title)
                XCTAssertEqual(copyright, photoInfo.copyright)
                expectation.fulfill()
            }
        }

        // Wait until the expectation is fulfilled, with a timeout of 5 seconds
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchPhotoInfoError() {

        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Download photo of the day")

        // Change the base URL, so no photoInfo is returned
        sut.baseURL = URL(string: "https://apple.com")!

        // Day to perfom the request
        let day = "2020-07-25"

        sut.fetchPhotoInfo(onDay: day) { (info) in
             // Assert that no info is returned and fulfill expectation
             XCTAssertNil(info, "PhotoInfo should be nil")
            expectation.fulfill()
        }

        // Wait until the expectation is fulfilled, with a timeout of 5 seconds
        wait(for: [expectation], timeout: 5.0)
    }
}
