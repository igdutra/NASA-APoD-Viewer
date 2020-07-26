//
//  PhotoViewModel.swift
//  NASA APoD Viewer
//
//  Created by Ivo Dutra on 26/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

protocol PhotoViewModelProtocol {
    var photos: [Int] { get set }
}

class PhotoViewModel: PhotoViewModelProtocol {
    var photos: [Int] = [1, 2, 3]

}
