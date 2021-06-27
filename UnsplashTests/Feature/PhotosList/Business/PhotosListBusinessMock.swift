//
//  PhotoListBusinessMock.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 17/06/21.
//

import UIKit
@testable import Unsplash

class PhotosListBusinessMock: PhotosListBusinessProtocol {

    enum State {
        case success
        case failure
    }

    var state: State = .success

    func fetchPhotos(with request: URLRequest?, completion: @escaping FetchPhotosCompletion<[Photo]>) {
        switch state {
        case .success:
            completion(.success([Photo.fixture()]))
        case .failure:
            completion(.failure(.noData))
        }
    }

    func fetchImage(by url: String, completion: @escaping FetchImageCompletion) {
        switch state {
        case .success:
            completion(UIImage())
        case .failure:
            completion(nil)
        }
    }
}
