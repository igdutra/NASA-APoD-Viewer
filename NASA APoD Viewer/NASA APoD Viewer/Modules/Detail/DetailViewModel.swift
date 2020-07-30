//
//  DetailViewModel.swift
//  NASA APoD Viewer
//
//  Created by Ivo Dutra on 30/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

protocol DetailViewModelProtocol {
    var info: PhotoInfo { get set }
}

class DetailViewModel: DetailViewModelProtocol {

    // MARK: - Properties
    
    var info: PhotoInfo

    // MARK: - Init

    init(info: PhotoInfo) {
        self.info = info
    }

}
