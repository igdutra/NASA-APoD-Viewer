//
//  PhotoTableViewCellViewModel.swift
//  NASA APoD Viewer
//
//  Created by Ivo Dutra on 27/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

/// ViewModel's Delegate is the View
protocol PhotoTableViewCellViewDelegate: class {
    func reloadImage()
}

class PhotoTableViewCellViewModel {

    // MARK: - Properties

    weak var delegate: PhotoTableViewCellViewDelegate?
    var photoInfoServices: PhotoInfoServicesProtocol
    var photoInfo: PhotoInfo?
    var image: UIImage {
        didSet {
            self.delegate?.reloadImage()
        }
    }

    // MARK: - Init

    init(delegate: PhotoTableViewCellViewDelegate, service: PhotoInfoServicesProtocol, day: String) {

        self.delegate = delegate
        photoInfoServices = service

        image = UIImage()

        // Retrieve photo from NASA
        fetchPhoto(onDay: day)
    }

    // MARK: - Get Photo

    /// Fetches the photo of the day
    func fetchPhoto(onDay day: String) {

        photoInfoServices.fetchPhotoInfo(onDay: day) { (infos) in

            if let info = infos {

                self.photoInfo = info

                // Request the image
                let imageTask = URLSession.shared.dataTask(with: info.url) { (data, _, _) in

                    guard let data = data, let image = UIImage(data: data) else { return }

                    // Load image and reload tableView
                    self.image = self.resizedImage(image)
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
