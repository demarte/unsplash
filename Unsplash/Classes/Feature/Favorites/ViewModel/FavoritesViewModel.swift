//
//  FavoritesViewModel.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 26/06/21.
//

import Foundation

class FavoritesViewModel: FavoritesViewModelProtocol {
    
    // MARK: - Public Properties
    
    private(set) var photos = Dynamic([Photo]())
    
    // MARK: - Private Properties
    
    private let provider: UserDefaultsProviderProtocol
    
    // MARK: - Initializer
    
    init(provider: UserDefaultsProviderProtocol = UserDefaultsProvider.standard) {
        self.provider = provider
    }
    
    // MARK: - Public Methods
    
    func fetchFavorites() {
        photos.value = provider.fetchPhotos()
    }
    
    func deleteAllPhotos() {
        guard photos.value.count > .zero else { return }
        provider.removeAllPhotos()
        photos.value = []
    }
}
