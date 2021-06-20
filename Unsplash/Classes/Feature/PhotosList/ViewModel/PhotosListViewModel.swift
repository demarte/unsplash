//
//  PhotosListViewModel.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation

enum PhotosListViewModelState {
    case loaded([Photo])
    case loading
    case error(APIResponseError)
}

final class PhotosListViewModel: PhotosListViewModelProtocol {

    // MARK: - Public Properties

    private(set) var state = Dynamic<PhotosListViewModelState>(.loading)
    private(set) var isFetching = Dynamic<Bool>(false)
    private(set) var currentPage: Int = .zero

    // MARK: - Private Properties

    private let manager: PhotosListManagerProtocol
    private var photos: [Photo] = []

    // MARK: - Initializer

    init(manager: PhotosListManagerProtocol = PhotosListManager()) {
        self.manager = manager
    }

    // MARK: - Public Methods

    func fetch() {
        currentPage += 1
        setUpLoading()
        manager.fetch(by: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                let count = self.photos.count
                self.photos.insert(contentsOf: photos, at: count)
                self.state.value = .loaded(self.photos)
            case .failure(let error):
                self.handleAPIError(error)
            }
            self.isFetching.value = false
        }
    }

    // MARK: - Private Methods

    private func handleAPIError(_ error: APIResponseError) {
        state.value = .error(error)
    }
    
    private func setUpLoading() {
        switch state.value {
        case .loading:
            isFetching.value = false
        default:
            isFetching.value = true
        }
    }
}
