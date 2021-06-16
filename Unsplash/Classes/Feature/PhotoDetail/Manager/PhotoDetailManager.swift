//
//  PhotoDetailManager.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation
import UIKit

class PhotoDetailManager: OperationQueue, PhotoDetailManagerProtocol {

    // MARK: - Public Properties

    func fetchPhotoDetails(photoURL: String, completion: @escaping FetchImageCompletion) {
        let operation = FetchImageOperation(urlString: photoURL, completion: completion)
        addOperation(operation)
    }
}
