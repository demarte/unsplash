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

// MARK: - Fixture

extension Photo {

    static func fixture(id: String? = "nxx0N1oAnPQ",
                        createdAt: String? = "2021-05-31T17:16:32-04:00",
                        updatedAt: String? = "2021-06-02T07:21:33-04:00",
                        width: Int? = 5464,
                        heigth: Int? = 8192,
                        color: String? = "#262626",
                        blurHash: String? = "L8AT1T?HMy~7v|xH%4={IUIXIXxG",
                        likes: Int? = 3,
                        description: String? = "my photo",
                        altDescription: String? = "woman in blue denim jacket sitting on black metal bench",
                        ulrs: PhotoURL = PhotoURL.fixture()) -> Photo {

        return Photo(id: id,
                     createdAt: createdAt,
                     updatedAt: updatedAt,
                     width: width,
                     height: heigth,
                     color: color,
                     blurHash: blurHash,
                     likes: likes,
                     description: description,
                     altDescription: altDescription,
                     urls: ulrs)
    }
}
