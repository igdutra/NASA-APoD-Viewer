//
//  PhotoInfoServicesMock.swift
//  NASA APoD Viewer Tests
//
//  Created by Ivo Dutra on 29/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

@testable import NASA_APoD_Viewer

class PhotoInfoServicesMock: PhotoInfoServicesProtocol {

    // MARK: - Properties

    var called: Bool

    // MARK: - Init

    init() {
        called = false
    }

    // MARK: - Delegate

    func fetchPhotoInfo(onDay: String, completion: @escaping (PhotoInfo?) -> Void) {
        called = true
    }

}
