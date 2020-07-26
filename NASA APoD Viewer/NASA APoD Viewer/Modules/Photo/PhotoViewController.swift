//
//  ViewController.swift
//  NASA APoD Viewer
//
//  Created by Ivo Dutra on 26/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    // MARK: - Properties

    var viewModel: PhotoViewModelProtocol?

//    weak var navigationDelegate: SearchResultsViewModelDelegate?

    private var myView: PhotoView {
        // swiftlint:disable force_cast
        return view as! PhotoView
        // swiftlint:enable force_cast
    }

    // MARK: - Life Cycle

    override func loadView() {
        let myView = PhotoView()
        view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let photoViewModel = PhotoViewModel()

        viewModel = photoViewModel
        myView.viewModel = viewModel

//        viewModel.navigationDelegate = self
    }
}
