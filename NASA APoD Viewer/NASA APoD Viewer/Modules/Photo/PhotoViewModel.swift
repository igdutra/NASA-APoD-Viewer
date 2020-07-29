//
//  PhotoViewModel.swift
//  NASA APoD Viewer
//
//  Created by Ivo Dutra on 26/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

/// ViewModel's Delegate is the View
protocol PhotoViewModelDelegate: class {
    func reloadTableView()
}

/// So that we can UnitTest
protocol PhotoViewModelProtocol {
    var delegate: PhotoViewModelDelegate? { get set }
    var image: UIImage { get set }
    var days: [String] { get set }
}

class PhotoViewModel: PhotoViewModelProtocol {

    // MARK: - Properties
    
    weak var delegate: PhotoViewModelDelegate?
    var image: UIImage
    var days: [String]

    // MARK: - Init

    init(delegate: PhotoViewModelDelegate, service: PhotoInfoServicesProtocol) {
        self.delegate = delegate

        // TableView loads the placeholder first
        image = UIImage.Default.photoPlaceholder!

        // Dates used to perform request
        days = [
            "2020-07-20",
            "2020-07-21",
            "2020-07-22",
            "2020-07-23",
            "2020-07-24",
            "2020-07-25"
        ]

    }

}
