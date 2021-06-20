//
//  PhotosListCellViewModel.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation
import UIKit

enum PhotosListCellViewModelState {
    case loaded(UIImage)
    case loading
    case empty
}

final class PhotosListCellViewModel: PhotosListCellViewModelProtocol {

    // MARK: - Public Properties

    private(set) var state = Dynamic<PhotosListCellViewModelState>(.empty)

    // MARK: - Private Properties

    private let photo: Photo
    private let manager: PhotosListManagerProtocol

    // MARK: - Initializer

    init(model: Photo, manager: PhotosListManagerProtocol = PhotosListManager()) {
        self.photo = model
        self.manager = manager
    }

    // MARK: - Public Methods

    func fetchImage() {
        state.value = .loading
        
        manager.retrieveImage(for: photo) { [weak self] result in
            guard let self = self else { return }
            if let image = result {
                self.state.value = .loaded(image)
            } else {
                self.state.value = .empty
            }
        }
    }
}
