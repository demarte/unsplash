//
//  PhotoListDetailViewModel.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation
import UIKit

enum PhotoDetailViewModelState {
    case loading
    case loaded(UIImage?)
    case error
}

class PhotoDetailViewModel: PhotoDetailViewModelProtocol {

    // MARK: - Public Properties

    private(set) var state = Dynamic<PhotoDetailViewModelState>(.loading)

    // MARK: - Private Properties

    private let manager: PhotoDetailManagerProtocol
    private let photo: Photo

    // MARK: - Initializer

    init(photo: Photo, manager: PhotoDetailManagerProtocol = PhotoDetailManager()) {
        self.manager = manager
        self.photo = photo
    }

    // MARK: Public Methods

    func fetchPhotoDetails() {
        guard let url = photo.urls?.full else { return }
        manager.fetchPhotoDetails(photoURL: url) { [weak self] result in
            guard let self = self else { return }
            if let image = result {
                self.state.value = .loaded(image)
            } else {
                self.state.value = .error
            }
        }
    }
}
