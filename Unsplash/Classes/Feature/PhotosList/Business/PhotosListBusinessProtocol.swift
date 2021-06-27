//
//  PhotosListBusinessProtocol.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 17/06/21.
//

import Foundation

protocol PhotosListBusinessProtocol {
    func fetchPhotos(with request: URLRequest?, completion: @escaping FetchPhotosCompletion<[Photo]>)
    func searchPhotos(with request: URLRequest?, completion: @escaping FetchPhotosCompletion<[Photo]>)
}
