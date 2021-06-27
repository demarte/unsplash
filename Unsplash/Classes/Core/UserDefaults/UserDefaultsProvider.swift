//
//  UserDefaultsProvider.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 27/06/21.
//

import Foundation

protocol UserDefaultsProviderProtocol {
    func save(photos: [Photo])
    func removeAllPhotos()
    func fetchPhotos() -> [Photo]
}

struct UserDefaultsProvider: UserDefaultsProviderProtocol {
    
    // MARK: - Singleton
    
    private init() { }
    
    static let standard = UserDefaultsProvider()
    
    // MARK: - Public API
    
    func save(photos: [Photo]) {
        UserDefaults.standard.set(photos.asJSONList, forKey: UserDefaultsKeys.photoKey.rawValue)
    }
    
    func removeAllPhotos() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.photoKey.rawValue)
    }
    
    func fetchPhotos() -> [Photo] {
        let data = UserDefaults.standard.array(forKey: UserDefaultsKeys.photoKey.rawValue)
        return [Photo](fromJSONList: data ?? [])
    }
}
