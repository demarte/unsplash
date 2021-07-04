//
//  PhotosListViewController.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import UIKit

class PhotosListViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let itemsPerRow: CGFloat = 3
        static let sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
        static let footerHeight: CGFloat = 80.0
        static let firstPage: String = "1"
        static let debounceTime: TimeInterval = 0.4
    }

    // MARK: - Public Properties

    var showDetails: ((Photo) -> Void)?
    var presentGenericError: (() -> Void)?

    // MARK: - Private Properties

    private let viewModel: PhotosListViewModelProtocol?
    private let debouncer = Debouncer(timeInterval: Constants.debounceTime)
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Localizable.placeholder.localize
        searchController.searchBar.delegate = self
        return searchController
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.refreshControl = refreshControl
        return collectionView
    }()

    private lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .lightGray
        activityView.hidesWhenStopped = true
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshColletionView), for: .valueChanged)
       return refreshControl
    }()
    
    // MARK: - Private Computed Properties
    
    private var emptyStateCellSize: CGSize {
        guard let viewModel = viewModel, viewModel.isFiltering else { return .zero }
        
        switch viewModel.state.value {
        case .loaded(let photos):
            return photos.isEmpty ? CGSize(width: collectionView.frame.width, height: collectionView.frame.height) : .zero
        default:
            return .zero
        }
    }

    // MARK: - Initializer

    init(viewModel: PhotosListViewModelProtocol) {
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
        setUpNavigationItem()
        setUpView()
        setUpConstraints()
        fetchPhotos()
        bindElements()
    }

    private func setUpView() {
        view.addSubview(collectionView)
        view.addSubview(activityView)
        view.backgroundColor = .systemBackground
        setUpCollectionView()
    }
    
    private func setUpNavigationItem() {
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(PhotosListCell.self, forCellWithReuseIdentifier: PhotosListCell.cellIdentifier)
        collectionView.register(EmptyStateCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: EmptyStateCell.identifier)
        collectionView.register(LoadingCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: LoadingCell.identifier)
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
    
    @objc
    private func refreshColletionView() {
        guard let viewModel = viewModel else { return }
        switch viewModel.state.value {
        case .error:
            viewModel.fetch()
        default:
            break
        }
        collectionView.refreshControl?.endRefreshing()
    }

    private func bindElements() {
        viewModel?.state.bind { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.handleLoading()
            case .loaded:
                self.handleLoaded()
            case .error(let error):
                self.handleError(error)
            }
        }

        viewModel?.isFetching.bind { [weak self] _ in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }

    private func handleLoading() {
        activityView.isHidden = false
        activityView.startAnimating()
    }

    private func handleLoaded() {
        activityView.stopAnimating()
        collectionView.reloadData()
    }

    private func handleError(_ apiError: APIResponseError) {
        activityView.stopAnimating()
        collectionView.reloadData()
        presentGenericError?()
    }

    private func scrollViewDidReachBottom() {
        viewModel?.fetch()
    }
    
    private func setUpPhotoCell(_ cell: PhotosListCell, at indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        switch viewModel.state.value {
        case .loaded(let photos):
            let photo = photos[indexPath.row]
            let viewModelCell = PhotosListCellViewModel(model: photo)
            cell.setUpCell(with: viewModelCell)
        default:
            return
        }
    }
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosListCell.cellIdentifier,
                                                            for: indexPath) as? PhotosListCell else {
            return UICollectionViewCell()
        }
        setUpPhotoCell(cell, at: indexPath)
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
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: EmptyStateCell.identifier,
                                                                                   for: indexPath) as? EmptyStateCell else {
                return UICollectionReusableView()
            }
            headerView.setUp(title: Localizable.notFound.localize, description: nil)
            return headerView
        } else {
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: LoadingCell.identifier,
                                                                                   for: indexPath) as? LoadingCell else {
                return UICollectionReusableView()
            }
            viewModel?.isFetching.value ?? false ? footerView.startLoading() : footerView.stopLoading()
            return footerView
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let viewModel = viewModel, !viewModel.isFetching.value, !viewModel.isFiltering else { return }
        switch viewModel.state.value {
        case .loaded:
            let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
            if bottomEdge >= scrollView.contentSize.height {
                scrollViewDidReachBottom()
            }
        default:
            break
        }
    }
}

// MARK: - CollectionView UICollectionViewDelegateFlowLayout

extension PhotosListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Constants.sectionInsets.left * (Constants.itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / Constants.itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return emptyStateCellSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: Constants.footerHeight)
    }
}

// MARK: - UISearchResultsUpdating

extension PhotosListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        debouncer.handler = { [weak self] in
            guard let self = self else { return }
            self.viewModel?.searchPhotos(by: searchText)
        }
        debouncer.renewInterval()
    }
}

extension PhotosListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.fetch()
    }
}
