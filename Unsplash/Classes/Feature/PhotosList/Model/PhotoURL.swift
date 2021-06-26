//
//  PhotoURL.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 02/06/21.
//

import Foundation

struct PhotoURL: Codable {
    
    // MARK: - Properties
    
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    // MARK: - Initializers
    
    init?(json: Data?) {
        guard let json = json, let model = try? JSONDecoder().decode(PhotoURL.self, from: json) else { return nil }
        self = model
    }
    
    init(raw: String?, full: String?, regular: String?, small: String?, thumb: String?) {
        self.raw = raw
        self.full = full
        self.regular = regular
        self.small = small
        self.thumb = thumb
    }
    
    // MARK: CodingKeys

    enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

// MARK: - Fixture

extension PhotoURL {
    static func fixture(raw: String? = nil,
                        full: String? = nil,
                        regular: String? = nil,
                        small: String? = nil,
                        thumb: String? = nil) -> PhotoURL {
        return PhotoURL(raw: raw, full: full, regular: regular, small: small, thumb: thumb)
    }
}
