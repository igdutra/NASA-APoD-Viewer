//
//  DetailViewController.swift
//  NASA APoD Viewer
//
//  Created by Ivo Dutra on 30/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties

    var viewModel: DetailViewModelProtocol?
    var photoInfo: PhotoInfo

    private var myView: DetailView {
        // swiftlint:disable force_cast
        return view as! DetailView
        // swiftlint:enable force_cast
    }

    // MARK: - Init

    init(info: PhotoInfo) {
        self.photoInfo = info
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func loadView() {
        let myView = DetailView()
        view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let detailViewModel = DetailViewModel(info: self.photoInfo)

        viewModel = detailViewModel
        myView.viewModel = viewModel

    }
}
