//
//  PhotoDetailManagerProtocol.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 20/06/21.
//

import Foundation

protocol PhotoDetailManagerProtocol {
    func retrieveImage(for photo: Photo, completion: @escaping FetchPhotoCompletion)
}
