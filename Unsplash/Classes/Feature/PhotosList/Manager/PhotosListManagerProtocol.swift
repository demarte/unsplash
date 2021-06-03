//
//  PhotosListManagerProtocol.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation

protocol PhotosListManagerProtocol {

    func fetch(completion: @escaping FetchPhotosCompletion<[Photo]>)
    func fetchImage(by urlString: String, completion: @escaping FetchImageCompletion)
}
