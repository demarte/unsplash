//
//  PhotosListViewController.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import UIKit

class PhotosListViewController: UIViewController {

    // MARK: - Public Properties

    var showDetails: ((Photo) -> Void)?

    // MARK: - Private Properties

    private let viewModel: PhotosListViewModelProtocol?
    private let sectionInsets = UIEdgeInsets(
      top: 50.0,
      left: 20.0,
      bottom: 50.0,
      right: 20.0)
    private let itemsPerRow: CGFloat = 3

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .lightGray
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraints()
        fetchPhotos()
        bindElements()
    }

    // MARK: - Initializer

    init(viewModel: PhotosListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = nil
        super.init(coder: coder)
    }

    // MARK: - Private Methods

    private func setUpView() {
        view.addSubview(collectionView)
        view.addSubview(activityView)
        view.backgroundColor = .systemBackground
        setUpCollectionView()
    }

    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(PhotosListCell.self, forCellWithReuseIdentifier: PhotosListCell.cellIdentifier)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func fetchPhotos() {
        viewModel?.fetch()
    }

    private func bindElements() {
        viewModel?.state.bind { [weak self] state in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch state {
                case .loading:
                    self.handleLoading()
                case .loaded(let photos):
                    self.handleLoaded(with: photos)
                case .error(let error):
                    self.handleError(error)
                }
            }
        }
    }

    private func handleLoading() {
        activityView.startAnimating()
        activityView.isHidden = false
    }

    private func handleLoaded(with photos: [Photo]) {
        activityView.stopAnimating()
        activityView.isHidden = true
        collectionView.reloadData()
    }

    private func handleError(_ apiError: APIResponseError) { }
}

// MARK: - CollectionView Delegate and DataSource

extension PhotosListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return .zero }
        switch viewModel.state.value {
        case .loading, .error:
            return .zero
        case .loaded(let photos):
            return photos.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosListCell.cellIdentifier,
                                                            for: indexPath) as? PhotosListCell else {
            return UICollectionViewCell()
        }
        switch viewModel.state.value {
        case .loaded(let photos):
            let photo = photos[indexPath.row]
            let viewModelCell = PhotosListCellViewModel(model: photo)
            cell.setUpCell(with: viewModelCell)
        default:
            break
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        switch viewModel.state.value {
        case .loaded(let photos):
            let photo = photos[indexPath.row]
            showDetails?(photo)
        default:
            return
        }
    }
}

// MARK: - CollectionView UICollectionViewDelegateFlowLayout

extension PhotosListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
