//
//  PhotoDetailManagerMock.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 20/06/21.
//

import UIKit
@testable import Unsplash

class PhotoDetailManagerMock: PhotoDetailManagerProtocol {
    
    enum State {
        case success
        case failure
    }

    var state: State = .success
    
    func retrieveImage(for photo: Photo, completion: @escaping FetchPhotoCompletion) {
        switch state {
        case .success:
            completion(.success(UIImage()))
        case .failure:
            completion(.failure(APIResponseError.invalidResponse))
        }
    }
}
