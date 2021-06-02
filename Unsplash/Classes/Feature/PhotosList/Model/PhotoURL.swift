//
//  PhotoURL.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 02/06/21.
//

import Foundation

struct PhotoURL: Codable {
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?

    enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
