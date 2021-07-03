//
//  FavoritesViewController.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 24/06/21.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    // MARK: Typealias
    
    typealias ConfirmationAlertAction = ((@escaping (UIAlertAction) -> Void) -> Void)
    
    // MARK: - Constants

    private enum Constants {
        static let numberOfSections: Int = 1
        static let itemsPerRow: CGFloat = 3
        static let sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    
    // MARK: - Public Properties
    
    var showDetails: ((Photo) -> Void)?
    var showConfirmationAlert: ConfirmationAlertAction?
    
    // MARK: - Private Properties
    
    private let viewModel: FavoritesViewModelProtocol
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Private Computed Properties
    
    private var photoCellSize: CGSize {
        let paddingSpace = Constants.sectionInsets.left * (Constants.itemsPerRow + 1)
        let availableWidth = view.bounds.width - paddingSpace
        let widthPerItem = availableWidth / Constants.itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    private var emptyStateCellSize: CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return viewModel.photos.value.isEmpty ? CGSize(width: width, height: height) : .zero
    }
    
    // MARK: - Initializer
    
    init(viewModel: FavoritesViewModelProtocol = FavoritesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        finishInit()
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = FavoritesViewModel()
        super.init(coder: coder)
        finishInit()
    }
    
    // MARK: - Override
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavorites()
        setUpNavigationItems()
    }
    
    // MARK: Private Properties
    
    private func finishInit() {
        setUpView()
        setUpConstraints()
        bindElements()
    }
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.register(PhotosListCell.self, forCellWithReuseIdentifier: PhotosListCell.cellIdentifier)
        collectionView.register(EmptyStateCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: EmptyStateCell.identifier)
    }
    
    private func setUpNavigationItems() {
        guard !viewModel.photos.value.isEmpty else { return }
        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAllPhotos))
        navigationItem.rightBarButtonItem = deleteItem
        view.layoutIfNeeded()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindElements() {
        viewModel.photos.bind { [weak self] _ in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
    
    @objc
    private func deleteAllPhotos() {
        showConfirmationAlert? { [weak self] action in
            guard let self = self else { return }
            if action.style == .destructive {
                self.viewModel.deleteAllPhotos()
            }
        }
    }
}

// MARK: - CollectionView Delegate and DataSource

extension FavoritesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosListCell.identifier, for: indexPath) as? PhotosListCell else {
            return UICollectionViewCell()
        }
        let photo = viewModel.photos.value[indexPath.row]
        let viewModel = PhotosListCellViewModel(model: photo)
        cell.setUpCell(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard viewModel.photos.value.isEmpty, let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: EmptyStateCell.identifier,
                                                                         for: indexPath) as? EmptyStateCell else {
            return UICollectionReusableView()
        }
        view.setUp(title: Localizable.emptyStateTitle.localize, description: Localizable.emptyStateDescription.localize)
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.photos.value[indexPath.row]
        showDetails?(photo)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return photoCellSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.sectionInsets.left
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.sectionInsets.top
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return emptyStateCellSize
    }
}
