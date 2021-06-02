//
//  APIResponseError.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation

enum APIResponseError: Error {
    case noData
    case invalidResponse
    case decodeError
}
