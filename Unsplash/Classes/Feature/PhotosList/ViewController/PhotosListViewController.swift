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
    }

    // MARK: - Public Properties

    var showDetails: ((Photo) -> Void)?

    // MARK: - Private Properties

    private let viewModel: PhotosListViewModelProtocol?
    private var showPaginationLoading = false

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .lightGray
        activityView.hidesWhenStopped = true
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

    private func bindElements() {
        viewModel?.state.bind { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.handleLoading()
            case .loaded(let photos):
                self.handleLoaded(with: photos)
            case .error(let error):
                self.handleError(error)
            }
        }

        viewModel?.isFetching.bind { [weak self] isFetching in
            guard let self = self else { return }
            self.showPaginationLoading = isFetching
            if isFetching {
//                self.collectionView.reloadSections(IndexSet(0...1))
            }
        }
    }

    private func handleLoading() {
        activityView.startAnimating()
        activityView.isHidden = false
    }

    private func handleLoaded(with photos: [Photo]) {
        activityView.stopAnimating()
        collectionView.reloadData()
    }

    private func handleError(_ apiError: APIResponseError) { }

    private func scrollViewDidReachBottom() {
        print("batman")
        viewModel?.fetch()
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

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: LoadingCell.identifier,
                                                                         for: indexPath) as? LoadingCell else {
            return UICollectionReusableView()
        }
        showPaginationLoading ? footerView.startLoading() : footerView.stopLoading()
        return footerView
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let viewModel = viewModel, !viewModel.isFetching.value else { return }
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height {
            scrollViewDidReachBottom()
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

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: Constants.footerHeight)
    }
}
