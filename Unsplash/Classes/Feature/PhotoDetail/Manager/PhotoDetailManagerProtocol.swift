//
//  PhotoDetailManagerProtocol.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation

protocol PhotoDetailManagerProtocol {

    func fetchPhotoDetails(photoURL: String, completion: @escaping FetchImageCompletion)
}
