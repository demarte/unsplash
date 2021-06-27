//
//  EmptyStateCell.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 26/06/21.
//

import UIKit

final class EmptyStateCell: UICollectionReusableView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let spacing: CGFloat = 8.0
    }
    
    // MARK: - Private Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.emptyStateTitle.localize
        label.font = UIFont.font(type: .bold, textStyle: .title2)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.emptyStateDescription.localize
        label.textColor = .white
        label.font = UIFont.font(type: .regular, textStyle: .callout)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let arrangedSubViews = [titleLabel, descriptionLabel]
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.spacing = Constants.spacing
        stackView.axis = .vertical
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
    
    // MARK: - Private Methods
    
    private func finishInit() {
        setUpView()
        setUpConstraints()
    }
    
    private func setUpView() {
        backgroundColor = .clear
        addSubview(stackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
