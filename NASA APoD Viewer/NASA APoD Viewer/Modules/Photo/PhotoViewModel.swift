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
    var photoInfoServices: PhotoInfoServicesProtocol { get set }
    var photosT: [Int] { get set }
    var photos: [PhotoInfo] { get set }
    var image: UIImage { get set }
}

class PhotoViewModel: PhotoViewModelProtocol {

    // MARK: - Properties
    weak var delegate: PhotoViewModelDelegate?
    var photoInfoServices: PhotoInfoServicesProtocol
    var photosT: [Int] = [1, 2, 3]
    var photos: [PhotoInfo]
    var image: UIImage

    // MARK: - Init

    init(delegate: PhotoViewModelDelegate, service: PhotoInfoServicesProtocol) {
        self.delegate = delegate
        photoInfoServices = service

        photos = []
        // TableView loads the placeholder first
        image = UIImage.Default.photoPlaceholder!

        // Retrieve photo from NASA
        fetchPhoto()
    }

    // MARK: - Get Photo

    /// Fetches the photo of the day
    func fetchPhoto() {

        photoInfoServices.fetchPhotoInfo { (infos) in

            if let info = infos {
                // Add current info to the array
                self.photos.append(info)

                // Request the image
                let imageTask = URLSession.shared.dataTask(with: info.url) { (data, _, _) in

                    guard let data = data, let image = UIImage(data: data) else { return }

                    // Load image and reload tableView
                    self.image = image
                    self.delegate?.reloadTableView()
                }

                imageTask.resume()
            }

        }
    }

}
