//
//  PhotoDetailViewModelMock.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 03/07/21.
//

import UIKit
@testable import Unsplash

class PhotoDetailViewModelMock: PhotoDetailViewModelProtocol {
    private(set) var state = Dynamic<PhotoDetailViewModelState>(.loading)
    
    func fetchPhotoDetails() {
        if let image = UIImage(named: "image_mock", in: Bundle(for: PhotosListManagerMock.self), compatibleWith: nil) {
            state.value = .loaded(image)
        }
    }
    
    func savePhoto() { }
    
    func removePhoto() { }
    
    func checkIfImageIsSaved() -> Bool {
        return false
    }
}
