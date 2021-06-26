//
//  Photo.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation

struct Photo: Codable {
    
    // MARK: - Properties
    
    var id: String?
    var createdAt, updatedAt: String?
    var width, height: Int?
    var color, blurHash: String?
    var description: String?
    var altDescription: String?
    var urls: PhotoURL?

    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    // MARK: - Initializers
    
    init?(json: Data?) {
        guard let json = json, let model = try? JSONDecoder().decode(Photo.self, from: json) else { return nil }
        self = model
    }
    
    init(id: String?, createdAt: String?, updatedAt: String?, width: Int?, height: Int?, color: String?, blurHash: String?, description: String?, altDescription: String?, urls: PhotoURL) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.width = width
        self.height = height
        self.color = color
        self.blurHash = blurHash
        self.description = description
        self.altDescription = altDescription
        self.urls = urls
    }
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height, color
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case urls
    }
}

// MARK: - Equatable

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Fixture

extension Photo {

    static func fixture(id: String? = "nxx0N1oAnPQ",
                        createdAt: String? = "2021-05-31T17:16:32-04:00",
                        updatedAt: String? = "2021-06-02T07:21:33-04:00",
                        width: Int? = 5464,
                        height: Int? = 8192,
                        color: String? = "#262626",
                        blurHash: String? = "L8AT1T?HMy~7v|xH%4={IUIXIXxG",
                        description: String? = "my photo",
                        altDescription: String? = "woman in blue denim jacket sitting on black metal bench",
                        urls: PhotoURL = PhotoURL.fixture()) -> Photo {

        return Photo(id: id,
                     createdAt: createdAt,
                     updatedAt: updatedAt,
                     width: width,
                     height: height,
                     color: color,
                     blurHash: blurHash,
                     description: description,
                     altDescription: altDescription,
                     urls: urls)
    }
}
