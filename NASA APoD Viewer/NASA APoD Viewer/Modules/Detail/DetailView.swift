//
//  DetailView.swift
//  NASA APoD Viewer
//
//  Created by Ivo Dutra on 30/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class DetailView: UIView {

    // MARK: - Properties

    var descriptionTextView: UITextView

    var viewModel: DetailViewModelProtocol? {
        didSet {
            configure()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        descriptionTextView = UITextView()

        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - View Codable

extension DetailView: ViewCodable {

    func configure() {
        guard let viewModel = viewModel else { return }

        // Add font, text and do not allow editing
        descriptionTextView.font = UIFont.Default.regular
        descriptionTextView.text = viewModel.info.description
        descriptionTextView.isEditable = false
    }

    func setupHierarchy() {
        self.addSubviews(descriptionTextView)
    }

    func setupConstraints() {
        descriptionTextView.setConstraints { (view) in
            view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        }
    }

    func render() { }

}
