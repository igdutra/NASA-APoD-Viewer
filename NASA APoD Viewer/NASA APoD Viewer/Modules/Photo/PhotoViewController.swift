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
        // TODO: add logic to catch last 5 days
        self.title = "Last 5 days photos"

        let photoViewModel = PhotoViewModel(delegate: myView, service: PhotoInfoServices())

        viewModel = photoViewModel
        myView.viewModel = viewModel

//        viewModel.navigationDelegate = self
    }
}
