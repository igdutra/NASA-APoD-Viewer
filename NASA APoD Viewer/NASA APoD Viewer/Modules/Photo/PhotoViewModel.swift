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
    var days: [String] { get set }
    var images: [UIImage?] { get set }
}

class PhotoViewModel: PhotoViewModelProtocol {

    // MARK: - Properties
    
    weak var delegate: PhotoViewModelDelegate?
    var photoInfoServices: PhotoInfoServicesProtocol
    var photoInfos: [PhotoInfo]
    var images: [UIImage?] {
        didSet {
            // DataSource must be reloaded when a image is set
            delegate?.reloadTableView()
        }
    }
    var days: [String]

    // MARK: - Init

    init(delegate: PhotoViewModelDelegate, service: PhotoInfoServicesProtocol) {
        self.delegate = delegate
        self.photoInfoServices = service

        photoInfos = []
        images = []

        // Dates used to perform request
        days = [
            "2020-07-18",
            "2020-07-20",
            "2020-07-21",
            "2020-07-22",
            "2020-07-23",
            "2020-07-24",
            "2020-07-25"
        ]

        // Make sure that when acessing viewModel.images[indexPath.row] is not out of range
        self.days.forEach { (_) in
            images.append(nil)
        }

        // Fetch all 5 photos
        getAllPhotos()
    }

    // MARK: - Get Photos

    // Get's all 5 photos and save it at the image array, at its correct position
    func getAllPhotos() {
        for (index, day) in days.enumerated() {
            fetchPhoto(onDay: day, { (image) in
                // Save image in the array, resized according to the device width
                self.images[index] = self.resizedImage(image, toFitWidth: UIScreen.main.bounds.width)
            })
        }

    }

    /// Fetches one photo of the day
    func fetchPhoto(onDay day: String, _ completion: @escaping (UIImage) -> Void) {

        photoInfoServices.fetchPhotoInfo(onDay: day) { (infos) in
            if let info = infos {
                // Save photo details
                self.photoInfos.append(info)
                // Request the image
                let imageTask = URLSession.shared.dataTask(with: info.url) { (data, _, _) in
                    guard let data = data, let image = UIImage(data: data) else { return }

                    // The image should be saved at the correct position from the images array
                    completion(image)
                }

                imageTask.resume()
            }
        }
    }

    // MARK: - UI Image Helper

    /// Calculate image correct size, based on device width
    func resizedImage(_ image: UIImage, toFitWidth width: CGFloat) -> UIImage {

        // Calculate resize ratio based on the device width (-16 to leading and trailing anchors)
        let resizeRatio = (width - 16) / image.size.width
        print(resizeRatio)
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
