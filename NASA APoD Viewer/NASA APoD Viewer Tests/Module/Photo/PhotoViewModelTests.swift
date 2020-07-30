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

    // MARK: - Delegate reload

    func testReloadTableView() {

        // Delegate's method is called at images didSet
        sut.images.append(UIImage())

        XCTAssert(photoViewMock.called)
    }

    // MARK: - Resize

    func testResizeImage() {
        // Load a image from Assets.xcassets, 1024 × 682.
        let rocket = UIImage(named: "rocket")
         // And then calculate its correct new height
        let aspectRatio = (UIScreen.main.bounds.width - 16) / (rocket?.size.width)!
        let newHeight = (rocket?.size.height)! * aspectRatio

        // Check if method produces the same height
        let resizedImage = sut.resizedImage(rocket!, toFitIn: UIScreen.main.bounds.width)
        XCTAssertEqual(resizedImage.size.height, newHeight, accuracy: 1)
    }

}
