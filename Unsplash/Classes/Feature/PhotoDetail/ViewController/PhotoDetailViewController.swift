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
        static let numberOfTaps: Int = 2
    }
    
    // MARK: - Public Properties

    var presentGenericError: (() -> Void)?

    // MARK: - Private Properties

    private let viewModel: PhotoDetailViewModelProtocol?

    private lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .lightGray
        activityView.hidesWhenStopped = true
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
    
    private var minZoomScale: CGFloat {
        let size = view.bounds.size
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        return min(widthScale, heightScale)
    }

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchPhotoDetails()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScale()
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
        guard let viewModel = viewModel  else { return }
        let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePhoto))
        let removeItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removePhoto))
        navigationItem.rightBarButtonItem = viewModel.checkIfImageIsSaved() ? removeItem : saveItem
        view.layoutIfNeeded()
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
        imageView.image = image
        imageView.sizeToFit()
        setUpScrollView()
        setUpNavigationItems()
    }

    private func handleError() {
        activityView.stopAnimating()
        presentGenericError?()
    }

    private func setUpScrollView() {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = Constants.numberOfTaps
        gesture.addTarget(self, action: #selector(handleDoubleTap))
        scrollView.contentSize = imageView.frame.size
        scrollView.addGestureRecognizer(gesture)
    }

    @objc
    private func handleDoubleTap() {
        guard scrollView.zoomScale != minZoomScale else { return }
        scrollView.zoom(to: imageView.bounds, animated: true)
    }
    
    @objc
    private func savePhoto() {
        viewModel?.savePhoto()
        setUpNavigationItems()
    }
    
    @objc
    private func removePhoto() {
        viewModel?.removePhoto()
        setUpNavigationItems()
    }

    private func updateMinZoomScale() {
        scrollView.minimumZoomScale = minZoomScale
        scrollView.zoomScale = minZoomScale
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
