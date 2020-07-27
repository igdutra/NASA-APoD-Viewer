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
                    self.image = self.resizedImage(image)
                    self.delegate?.reloadTableView()
                }

                imageTask.resume()
            }

        }
    }

    /// Calculate image correct size, based on device width
    func resizedImage(_ image: UIImage) -> UIImage {

        // Calculate resize ratio based on the device width (-16 to leading and trailing anchors)
        let resizeRatio = (UIScreen.main.bounds.width - 16) / image.size.width
        // Apply same ratio to both dimensions, in order to respect its aspect Ratio
        let size = image.size.applying(CGAffineTransform(scaleX: resizeRatio, y: resizeRatio))
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen

        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.draw(in: CGRect(origin: .zero, size: size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage?.withRoundedCorners(radius: 12) ?? UIImage()
    }
}
