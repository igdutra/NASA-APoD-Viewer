//
//  ViewController.swift
//  NASA APoD Viewer
//
//  Created by Ivo Dutra on 26/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

protocol PhotoNavigationDelegate: class {
    func goToDetail(fromPhoto: PhotoInfo)
}

class PhotoViewController: UIViewController {

    // MARK: - Properties

    var viewModel: PhotoViewModelProtocol?

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
        // TODO: add logic to catch last the current week
        self.title = "Last week photos"

        let photoViewModel = PhotoViewModel(delegate: myView,
                                            service: PhotoInfoServices(),
                                            navigation: self)

        viewModel = photoViewModel
        myView.viewModel = viewModel
    }
}

    // MARK: - Navigation

extension PhotoViewController: PhotoNavigationDelegate {

    func goToDetail(fromPhoto photo: PhotoInfo) {
        let detailController = DetailViewController(info: photo)
        self.navigationController?.pushViewController(detailController, animated: true)
    }

}
