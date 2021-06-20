//
//  PhotoDetailManager.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 20/06/21.
//

import Foundation
import Kingfisher

typealias FetchPhotoCompletion = (Result<UIImage, Error>) -> Void

final class PhotoDetailManager: PhotoDetailManagerProtocol {
    
    // MARK: - Private Properties
    
    private let manager: KingfisherManager
    
    // MARK: - Initializers
    
    init(manager: KingfisherManager = KingfisherManager.shared) {
        self.manager = manager
    }
    
    // MARK: - Public Methods
    
    func retrieveImage(for photo: Photo, completion: @escaping FetchPhotoCompletion) {
        guard let urlString = photo.urls?.full, let url = URL(string: urlString) else {
            completion(.failure(APIResponseError.noData))
            return
        }
        
        manager.retrieveImage(with: url) { result in
            switch result {
            case .success(let retrievedImage):
                completion(.success(retrievedImage.image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
