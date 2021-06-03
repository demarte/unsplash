//
//  PhotosListManagerMock.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation
@testable import Unsplash

class PhotosListManagerMock: PhotosListManagerProtocol {

    enum State {
        case success
        case failure
    }

    var state: State = .success

    func fetch(completion: @escaping FetchPhotosCompletion<[Photo]>) {
        switch state {
        case .success:
            completion(.success([Photo.fixture()]))
        case .failure:
            completion(.failure(APIResponseError.invalidResponse))
        }
    }
}
