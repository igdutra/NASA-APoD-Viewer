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

    // MARK: - Table View

extension PhotoView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.days.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }

        if let cell = tableView.dequeueReusableCell(withIdentifier: photoTableViewCellId) as? PhotoTableViewCell {
            // Update CentralImageView or use the placeholder before request is finished
            cell.centralImageView.image = viewModel.images[indexPath.row] ?? UIImage.Default.photoPlaceholder!

            // Add title according to the day
            let day = viewModel.days[indexPath.row]
            cell.titleLabel.text = viewModel.photoInfos[day]?.title ?? ""
            
            return cell
        }

        return UITableViewCell()
    }

}

    // MARK: - Delegate

extension PhotoView: PhotoViewModelDelegate {

    /// Reload Table View on the main Thread
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

    // MARK: - View Codable

extension PhotoView: ViewCodable {

    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: photoTableViewCellId)
    }

    func setupHierarchy() {
        self.addSubviews(tableView)
    }

    func setupConstraints() {

        tableView.setConstraints { (view) in
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
    }

    func render() { }

    func updateView() { }

    // MARK: - View Codable Helpers

}
