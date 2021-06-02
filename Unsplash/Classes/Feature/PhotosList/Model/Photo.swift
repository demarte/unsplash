//
//  Photo.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    var id: String?
    var createdAt, updatedAt: String?
    var width, height: Int?
    var color, blurHash: String?
    var likes: Int?
    var description: String?
    var altDescription: String?
    var urls: PhotoURL?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height, color
        case blurHash = "blur_hash"
        case likes
        case description
        case altDescription = "alt_description"
        case urls
    }
}
