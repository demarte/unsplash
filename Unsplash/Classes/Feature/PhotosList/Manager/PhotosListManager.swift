//
//  PhotosListManager.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation

typealias FetchPhotosCompletion<T: Decodable> = (Result<T, APIResponseError>) -> Void

class PhotosListManager: OperationQueue, PhotosListManagerProtocol {

    // MARK: - Public Methods

    func fetch(completion: @escaping FetchPhotosCompletion<[Photo]>) {
        let fetchOperation = PhotosListOperation(completion: completion)
        addOperation(fetchOperation)
    }
}
