//
//  PhotoDetailManager.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation

typealias PhotoDetailCompletion = (Result<Photo, APIResponseError>) -> Void

class PhotoDetailManager: OperationQueue, PhotoDetailManagerProtocol {

    // MARK: - Public Properties

    func fetchPhotoDetails(photoId: String, completion: @escaping PhotoDetailCompletion) {
        let operation = PhotoDetailOperation(photoId: photoId, completion: completion)
        addOperation(operation)
    }
}
