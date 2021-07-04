//
//  ConnectionErrorView.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/07/21.
//

import UIKit

final class ConnectionErrorView: UICollectionReusableView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let spacing: CGFloat = 8.0
        static let warningIconSize: CGFloat = 30.0
        static let warningIconName: String = "wifi.slash"
    }
    
    // MARK: - Private Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(type: .semiBold, textStyle: .headline)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var warningIcon: UIImageView = {
        let largeFont = UIFont.systemFont(ofSize: Constants.warningIconSize)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: Constants.warningIconName, withConfiguration: configuration)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let arrangedSubViews = [warningIcon, titleLabel]
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.spacing = Constants.spacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        finishInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        finishInit()
    }
    
    // MARK: - Public Methods
    
    func setUp(title: String?) {
        titleLabel.text = title
    }
    
    // MARK: - Private Methods
    
    private func finishInit() {
        setUpView()
        setUpConstraints()
    }
    
    private func setUpView() {
        backgroundColor = .error
        addSubview(stackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
