//
//  PhotoDetailManagerMock.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 17/06/21.
//

import UIKit
@testable import Unsplash

class PhotoDetailManagerMock: PhotoDetailManagerProtocol {
    enum State {
        case success
        case failure
    }

    var state: State = .success

    func fetchPhotoDetails(photoURL: String, completion: @escaping FetchImageCompletion) {
        switch state {
        case .success:
            completion(UIImage())
        case .failure:
            completion(nil)
        }
    }
}
