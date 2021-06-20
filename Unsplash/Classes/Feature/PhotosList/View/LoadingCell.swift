//
//  LoadingCell.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 18/06/21.
//

import UIKit

final class LoadingCell: UICollectionReusableView {

    // MARK: - Private Properties

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .lightGray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    // MARK: Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        finishInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        finishInit()
    }

    // MARK: - Public Methods

    func startLoading() {
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
    }

    // MARK: - Private Methods

    private func finishInit() {
        setUpView()
    }

    private func setUpView() {
        addSubview(activityIndicator)
        setUpConstraints()
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
