//
//  PhotoDetailManager.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation
import UIKit

class PhotoDetailManager: OperationQueue, PhotoDetailManagerProtocol {

    // MARK: - Private Properties

    private var business: PhotosListBusinessProtocol

    // MARK: - Initializer

    init(business: PhotosListBusinessProtocol = PhotosListBusiness()) {
        self.business = business
    }

    // MARK: - Public Properties

    func fetchPhotoDetails(photoURL: String, completion: @escaping FetchImageCompletion) {
        let operation = FetchImageOperation(urlString: photoURL, business: business)
        operation.completionBlock = {
            DispatchQueue.main.async {
                completion(operation.image)
            }
        }
        addOperation(operation)
    }
}
