//
//  PhotoDetailViewController.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    private enum Constants {
        static let padding: CGFloat = 8.0
    }

    // MARK: - Private Properties

    private let viewModel: PhotoDetailViewModelProtocol?

    private lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .lightGray
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()

    private var imageViewTopConstraint: NSLayoutConstraint?
    private var imageViewBottomConstraint: NSLayoutConstraint?
    private var imageViewLeadingConstraint: NSLayoutConstraint?
    private var imageViewTrailingConstraint: NSLayoutConstraint?

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchPhotoDetails()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }

    // MARK: - Initializer

    init(viewModel: PhotoDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        finishInit()
    }

    required init?(coder: NSCoder) {
        self.viewModel = nil
        super.init(coder: coder)
        finishInit()
    }

    // MARK: - Private Methods

    private func finishInit() {
        setUpNavigationItems()
        setUpView()
        bindElements()
        setUpScrollViewConstraints()
        setUpImageViewConstraints()
    }

    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        view.addSubview(activityView)
        scrollView.addSubview(imageView)
    }
    
    private func setUpNavigationItems() {
        let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePhoto))
        navigationItem.rightBarButtonItem = saveItem
    }

    private func bindElements() {
        viewModel?.state.bind { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loaded(let image):
                self.handleLoaded(with: image)
            case .loading:
                self.handleLoading()
            case .error:
                self.handleError()
            }
        }
    }

    private func setUpScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .zero),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .zero),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.padding),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.padding),
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setUpImageViewConstraints() {
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        imageViewBottomConstraint = imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        imageViewLeadingConstraint = imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        imageViewTrailingConstraint = imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)

        NSLayoutConstraint.activate([
            imageViewTopConstraint ?? NSLayoutConstraint(),
            imageViewBottomConstraint ?? NSLayoutConstraint(),
            imageViewLeadingConstraint ?? NSLayoutConstraint(),
            imageViewTrailingConstraint ?? NSLayoutConstraint()
        ])
    }

    private func handleLoading() {
        activityView.startAnimating()
        activityView.isHidden = false
    }

    private func handleLoaded(with image: UIImage?) {
        activityView.stopAnimating()
        activityView.isHidden = true
        imageView.image = image
        imageView.sizeToFit()
        setUpScrollView()
    }

    private func handleError() {
        /* not implemented */
    }

    private func setUpScrollView() {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 2
        gesture.addTarget(self, action: #selector(handleDoubleTap))
        scrollView.contentSize = imageView.frame.size
        scrollView.addGestureRecognizer(gesture)
    }

    @objc
    private func handleDoubleTap() {
        scrollView.zoom(to: imageView.bounds, animated: true)
    }
    
    @objc
    private func savePhoto() {
        viewModel?.savePhoto()
    }

    private func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }

    private func updateConstraints(for size: CGSize) {
        let yOffset = max(.zero, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint?.constant = yOffset
        imageViewBottomConstraint?.constant = yOffset

        let xOffset = max(.zero, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint?.constant = xOffset
        imageViewTrailingConstraint?.constant = xOffset
        view.layoutIfNeeded()
    }
}

// MARK: - ScrollView Delegate

extension PhotoDetailViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraints(for: view.bounds.size)
    }
}
