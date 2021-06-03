//
//  PhotoListDetailViewModel.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation

enum PhotoDetailViewModelState {
    case loading
    case loaded(Photo)
    case error(APIResponseError)
}

class PhotoDetailViewModel: PhotoDetailViewModelProtocol {

    // MARK: - Public Properties

    private(set) var state = Dynamic<PhotoDetailViewModelState>(.loading)

    // MARK: - Private Properties

    private let manager: PhotoDetailManagerProtocol
    private let photoId: String

    // MARK: - Initializer

    init(photoId: String, manager: PhotoDetailManagerProtocol = PhotoDetailManager()) {
        self.manager = manager
        self.photoId = photoId
    }

    // MARK: Public Methods

    func fetchPhotoDetails() {
        manager.fetchPhotoDetails(photoId: photoId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photo):
                self.state.value = .loaded(photo)
            case .failure(let error):
                self.state.value = .error(error)
            }
        }
    }
}
