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

    // MARK: - Private Properties

    private let manager: PhotosListManagerProtocol

    // MARK: - Initializer

    init(manager: PhotosListManagerProtocol = PhotosListManager()) {
        self.manager = manager
    }

    // MARK: - Public Methods

    func fetch() {
        manager.fetch { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                self.state.value = .loaded(photos)
            case .failure(let error):
                self.handleAPIError(error)
            }
        }
    }

    // MARK: - Private Methods

    private func handleAPIError(_ error: APIResponseError) {
        state.value = .error(error)
    }
}
