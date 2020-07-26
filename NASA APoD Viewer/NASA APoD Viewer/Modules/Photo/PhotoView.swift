//
//  PhotoView.swift
//  NASA APoD Viewer
//
//  Created by Ivo Dutra on 26/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class PhotoView: UIView {

    // MARK: - Properties

    var tableView: UITableView
    var photoTableViewCellId: String

    var viewModel: PhotoViewModelProtocol? {
        didSet {
            updateView()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        tableView = UITableView()
        photoTableViewCellId = "photoCell"

        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }

        if let cell = tableView.dequeueReusableCell(withIdentifier: photoTableViewCellId) {
            cell.textLabel?.text = String(viewModel.photos[indexPath.row])
        }
        
        return UITableViewCell()
    }

}

extension PhotoView: ViewCodable {

    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: photoTableViewCellId)
    }

    func setupHierarchy() {
        self.addSubviews(tableView)
    }

    func setupConstraints() {

        tableView.setConstraints { (view) in
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }

    }

    func render() {

    }

    func updateView() {

    }

    // MARK: - View Codable Helpers

}
