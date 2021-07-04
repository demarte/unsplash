//
//  GenericErrorViewController.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 04/07/21.
//

import UIKit

final class GenericErrorViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let spacing: CGFloat = 8.0
        static let buttonPadding: CGFloat = 24.0
        static let buttonHeight: CGFloat = 48.0
        static let warningIconSize: CGFloat = 80.0
        static let closeButtonIconSize: CGFloat = 28.0
        static let closeButtonIconName: String = "xmark"
        static let warningIconName: String = "exclamationmark.triangle"
    }
    
    // MARK: - Public Properties
    
    var dismissModal: (() -> Void)?
    
    // MARK: - Private Properties
    
    private lazy var closeButton: UIButton = {
        let image = UIImage(systemName: Constants.closeButtonIconName)
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        let font = UIFont.systemFont(ofSize: Constants.closeButtonIconSize)
        let configuration = UIImage.SymbolConfiguration(font: font)
        button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        button.tintColor = .secondaryLabel
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
    }()
    
    private lazy var warningIcon: UIImageView = {
        let largeFont = UIFont.systemFont(ofSize: Constants.warningIconSize)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: Constants.warningIconName, withConfiguration: configuration)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .secondaryLabel
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(type: .bold, textStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Localizable.genericErrorTitle.localize
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(type: .regular, textStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Localizable.genericErrorDescription.localize
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let arrangedSubViews = [warningIcon, titleLabel, descriptionLabel]
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.spacing = Constants.spacing
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initializer
    
    init() {
        super.init(nibName: nil, bundle: nil)
        finishInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        finishInit()
    }
    
    // MARK: - Private Methods
    
    private func finishInit() {
        setUpView()
        setUpConstraints()
    }
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubview(closeButton)
        view.addSubview(stackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.buttonHeight),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.buttonPadding),
            closeButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            closeButton.widthAnchor.constraint(equalToConstant: Constants.buttonHeight),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc
    private func didTapClose() {
        dismissModal?()
    }
}
