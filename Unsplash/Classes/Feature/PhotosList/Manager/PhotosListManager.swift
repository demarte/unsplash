//
//  PhotosListManager.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation
import UIKit
import Kingfisher

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

    func fetch(by pageNumber: Int, completion: @escaping FetchPhotosCompletion<[Photo]>) {
        let fetchOperation = PhotosListOperation(pageNumber: pageNumber, business: business)
        fetchOperation.completionBlock = {
            DispatchQueue.main.async {
                completion(fetchOperation.photosListResult ?? .failure(.noData))
            }
        }
        addOperation(fetchOperation)
    }
    
    func searchPhotos(by searchTerm: String, completion: @escaping FetchPhotosCompletion<[Photo]>) {
        let searchOperation = SearchPhotosOperation(searchTerm: searchTerm, business: business)
        searchOperation.completionBlock = {
            DispatchQueue.main.async {
                completion(searchOperation.photosListResult ?? .failure(.noData))
            }
        }
        addOperation(searchOperation)
    }
    
    func retrieveImage(for photo: Photo, completion: @escaping FetchImageCompletion) {
        guard let urlString = photo.urls?.small, let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let imageResource = ImageResource(downloadURL: url, cacheKey: photo.id)

        KingfisherManager.shared.retrieveImage(with: imageResource) { result in
            switch result {
            case .success(let retrievedImage):
                completion(retrievedImage.image)
            case .failure:
                completion(nil)
            }
        }
    }
}
