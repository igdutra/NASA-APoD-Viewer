//
//  PhotoViewModelTests.swift
//  NASA APoD Viewer Tests
//
//  Created by Ivo Dutra on 29/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import XCTest
@testable import NASA_APoD_Viewer

class PhotoViewModelTests: XCTestCase {

    var sut: PhotoViewModel!
    var photoViewMock: PhotoViewMock!
    var servicesMock: PhotoInfoServicesMock!

    override func setUp() {
        super.setUp()
        photoViewMock = PhotoViewMock()
        servicesMock = PhotoInfoServicesMock()

        sut = PhotoViewModel(delegate: photoViewMock, service: servicesMock)
    }

    override func tearDown() {
        sut = nil
        photoViewMock = nil
        servicesMock = nil
        super.tearDown()
    }

    // MARK: - delegate reload

    func testReloadTableView() {
        sut.images.append(UIImage())

        XCTAssert(photoViewMock.called)
    }

    // MARK: - resize

    func testResizeImage() {
        let rocket = UIImage(named: "rocket")

        // This image is 1024 × 682.

        let resizedImage = sut.resizedImage(rocket!, toFitWidth: UIScreen.main.bounds.width)

        let aspectRatio = (UIScreen.main.bounds.width - 16) / (rocket?.size.width)!

        let newHeight = (rocket?.size.height)! * aspectRatio

        XCTAssertEqual(resizedImage.size.height, newHeight, accuracy: 1)
    }

}
