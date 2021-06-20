//
//  PhotosListManagerProtocol.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation

protocol PhotosListManagerProtocol {

    func fetch(by pageNumber: Int, completion: @escaping FetchPhotosCompletion<[Photo]>)
    func retrieveImage(for photo: Photo, completion: @escaping FetchImageCompletion)
}
