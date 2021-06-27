//
//  PhotoListDetailViewModel.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation
import UIKit
import Kingfisher

enum PhotoDetailViewModelState {
    case loading
    case loaded(UIImage?)
    case error
}

class PhotoDetailViewModel: PhotoDetailViewModelProtocol {

    // MARK: - Public Properties

    private(set) var state = Dynamic<PhotoDetailViewModelState>(.loading)

    // MARK: - Private Properties

    private let photo: Photo
    private let manager: PhotoDetailManagerProtocol
    private let provider: UserDefaultsProviderProtocol

    // MARK: - Initializer

    init(photo: Photo,
         manager: PhotoDetailManagerProtocol = PhotoDetailManager(),
         provider: UserDefaultsProviderProtocol = UserDefaultsProvider.standard) {
        self.photo = photo
        self.manager = manager
        self.provider = provider
    }

    // MARK: Public Methods

    func fetchPhotoDetails() {
        manager.retrieveImage(for: photo) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.state.value = .loaded(image)
            case .failure:
                self.state.value = .error
            }
        }
    }
    
    func savePhoto() {
        var retrievedPhotos = retrievePhotos()
        if !retrievedPhotos.contains(photo) {
            retrievedPhotos.append(photo)
            save(photos: retrievedPhotos)
        }
    }
    
    func removePhoto() {
        var retrievedPhotos = retrievePhotos()
        if let index = retrievedPhotos.firstIndex(where: { $0 == photo }) {
            retrievedPhotos.remove(at: index)
            save(photos: retrievedPhotos)
        }
    }
        
    func checkIfImageIsSaved() -> Bool {
        let retrievedPhotos = retrievePhotos()
        return !retrievedPhotos.isEmpty && retrievedPhotos.contains(photo)
    }
    
    // MARK: - Private Methods
    
    private func retrievePhotos() -> [Photo] {
        return provider.fetchPhotos()
    }
    
    private func save(photos: [Photo]) {
        provider.save(photos: photos)
    }
}
