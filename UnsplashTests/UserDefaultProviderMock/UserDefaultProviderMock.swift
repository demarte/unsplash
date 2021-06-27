//
//  UserDefaultProviderMock.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 27/06/21.
//

@testable import Unsplash

class UserDefaultsProviderMock: UserDefaultsProviderProtocol {
    
    var photos: [Photo] = [Photo.fixture(), Photo.fixture()]
    
    func save(photos: [Photo]) {
        self.photos = photos
    }
    
    func removeAllPhotos() {
        photos = []
    }
    
    func fetchPhotos() -> [Photo] {
        return photos
    }
}
