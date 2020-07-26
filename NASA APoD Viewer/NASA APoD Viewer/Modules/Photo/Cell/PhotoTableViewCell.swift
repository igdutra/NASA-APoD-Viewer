//
//  PhotoTableViewCell.swift
//  NASA APoD Viewer
//
//  Created by Ivo Dutra on 26/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    // MARK: - Properties
    var centralImageView: UIImageView

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        centralImageView = UIImageView()

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - View Codable

extension PhotoTableViewCell: ViewCodable {

    func configure() {
        // This enables the view to be pinned to the borders
        centralImageView.contentMode = .scaleAspectFit

        // Add placeholder photo
        centralImageView.image = UIImage.Default.photoPlaceholder
    }

    func setupHierarchy() {
        self.addSubviews(centralImageView)
    }

    func setupConstraints() {
        centralImageView.setConstraints { (view) in
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
    }

    func render() { }

    func updateView() { }

}