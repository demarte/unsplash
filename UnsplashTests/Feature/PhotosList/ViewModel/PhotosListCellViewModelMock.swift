//
//  PhotosListCellViewModelMock.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 03/07/21.
//

import UIKit
@testable import Unsplash

class PhotosListCellViewModelMock: PhotosListCellViewModelProtocol {
    var state = Dynamic<PhotosListCellViewModelState>(.empty)
        
    func fetchImage() {
        if let image = UIImage(named: "image_mock", in: Bundle(for: PhotosListManagerMock.self), compatibleWith: nil) {
            state.value = .loaded(image)
        }
    }
}
