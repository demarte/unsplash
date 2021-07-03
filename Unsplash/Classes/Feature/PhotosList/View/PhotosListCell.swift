//
//  PhotosListCell.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import UIKit

final class PhotosListCell: UICollectionViewCell {

    // MARK: - Constants

    private enum Constants {
        static let padding: CGFloat = 4.0
    }

    // MARK: - Private Properties
    private var viewModel: PhotosListCellViewModelProtocol?

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .lightGray
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
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

    // MARK: - Public Methods

    func setUpCell(with viewModel: PhotosListCellViewModelProtocol) {
        self.viewModel = viewModel
        bindElements()
        self.viewModel?.fetchImage()
    }

    // MARK: - Private Methods

    private func finishInt() {
        setUpView()
        setUpConstraints()
    }

    private func setUpView() {
        addSubview(imageView)
        addSubview(activityView)
        backgroundColor = .white
        contentMode = .scaleAspectFit
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding),
            activityView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func bindElements() {
        viewModel?.state.bind { [weak self] state in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch state {
                case .loading:
                    self.handleLoading()
                case .loaded(let image):
                    self.handleLoaded(with: image)
                case .empty:
                    break
                }
            }
        }
    }

    private func handleLoading() {
        activityView.startAnimating()
        activityView.isHidden = false
    }

    private func handleLoaded(with image: UIImage) {
        activityView.isHidden = true
        imageView.image = image
    }
}
