//
//  PhotosListCell.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import UIKit

final class PhotosListCell: UICollectionViewCell {

    // MARK: - Private Properties

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        finishInt()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        finishInt()
    }

    // MARK: Override

    override func prepareForReuse() {
        imageView.image = nil
    }

    // MARK: - Public Methods

    func setUpCell(with photo: Photo) {
        guard let url = URL(string: photo.urls?.small ?? String()),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else { return }
        imageView.image = image
    }

    // MARK: - Private Methods

    private func finishInt() {
        setUpView()
        setUpConstraints()
    }

    private func setUpView() {
        addSubview(imageView)
        backgroundColor = .white
        contentMode = .scaleAspectFit
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0)
        ])
    }
}
