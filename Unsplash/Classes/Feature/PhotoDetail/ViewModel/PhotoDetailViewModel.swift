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

    // MARK: - Initializer

    init(photo: Photo, manager: PhotoDetailManagerProtocol = PhotoDetailManager()) {
        self.photo = photo
        self.manager = manager
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
        let data = UserDefaults.standard.array(forKey: UserDefaultsKeys.photoKey.rawValue)
        var retrivedPhotos = [Photo](fromJSONList: data ?? [])
        if !retrivedPhotos.contains(photo) {
            retrivedPhotos.append(photo)
            UserDefaults.standard.set(retrivedPhotos.asJSONList, forKey: UserDefaultsKeys.photoKey.rawValue)
        }
    }
}
