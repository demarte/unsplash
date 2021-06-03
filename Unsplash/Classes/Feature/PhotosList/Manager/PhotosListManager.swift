//
//  PhotosListManager.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation

typealias FetchPhotosCompletion<T: Decodable> = (Result<T, APIResponseError>) -> Void

class PhotosListManager: OperationQueue, PhotosListManagerProtocol {

    // MARK: - Private Properties

    private let provider: APIProviderProtocol

    // MARK: - Initializer

    init(provider: APIProviderProtocol = APIProvider()) {
        self.provider = provider
    }

    // MARK: - Public Methods

    func fetch(completion: @escaping FetchPhotosCompletion<[Photo]>) {
        let fetchOperation = PhotosListOperation(provider: provider, completion: completion)
        addOperation(fetchOperation)
    }
}
