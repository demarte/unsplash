//
//  FavoritesViewModelProtocol.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 27/06/21.
//

import Foundation

protocol FavoritesViewModelProtocol {
    var photos: Dynamic<[Photo]> { get }
    
    func fetchFavorites()
    func deleteAllPhotos()
}
