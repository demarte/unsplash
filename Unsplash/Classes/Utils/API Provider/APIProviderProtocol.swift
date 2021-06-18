//
//  APIProviderProtocol.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation

protocol APIProviderProtocol {

    func request<T: Decodable>(_ type: T.Type, urlRequest: URLRequest?, completion: @escaping NetworkCompletion<T>)
    func requestImage(from url: String, completion: @escaping ImageNetworkCompletion)
}
