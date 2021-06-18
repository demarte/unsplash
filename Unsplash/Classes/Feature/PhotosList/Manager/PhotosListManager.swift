//
//  PhotosListManager.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation
import UIKit

typealias FetchPhotosCompletion<T: Decodable> = (Result<T, APIResponseError>) -> Void
typealias FetchImageCompletion = (UIImage?) -> Void

class PhotosListManager: OperationQueue, PhotosListManagerProtocol {

    // MARK: - Private Properties

    private var business: PhotosListBusinessProtocol

    // MARK: - Initializer

    init(business: PhotosListBusinessProtocol = PhotosListBusiness()) {
        self.business = business
    }

    // MARK: - Public Methods

    func fetch(completion: @escaping FetchPhotosCompletion<[Photo]>) {
        let fetchOperation = PhotosListOperation(business: business)
        fetchOperation.completionBlock = {
            DispatchQueue.main.async {
                completion(fetchOperation.photosListResult ?? .failure(.noData))
            }
        }
        addOperation(fetchOperation)
    }

    func fetchImage(by urlString: String, completion: @escaping FetchImageCompletion) {
        let fetchImageOperation = FetchImageOperation(urlString: urlString, business: business)
        fetchImageOperation.completionBlock = {
            DispatchQueue.main.async {
                completion(fetchImageOperation.image)
            }
        }
        addOperation(fetchImageOperation)
    }
}
