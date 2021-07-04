//
//  ConnectionErrorView.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/07/21.
//

import UIKit

final class ConnectionErrorView: UIView {
    
    // MARK: - Private Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(type: .bold, textStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let arrangedSubViews = [titleLabel]
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    func setUpView(with title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Private Methods
    
    private func finishInt() {
        setUpView()
        setUpConstraints()
    }

    private func setUpView() {
        backgroundColor = .gray
        addSubview(titleLabel)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
