//
//  APIProvider.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation
import UIKit

typealias NetworkCompletion<T: Decodable> = (() throws ->  T) -> Void
typealias ImageNetworkCompletion = (UIImage?) -> Void

struct APIProvider: APIProviderProtocol {

    // MARK: - Public Methods

    func request<T: Decodable>(_ type: T.Type, urlRequest: URLRequest?, completion: @escaping NetworkCompletion<T>) {
        guard let urlRequest = urlRequest else {
            completion { throw APIResponseError.noData }
            return
        }
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, _ in
            guard let response = urlResponse, let data = data else {
                completion { throw APIResponseError.noData }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                completion { throw APIResponseError.invalidResponse }
                return
            }

            do {
                let parsedObject = try JSONDecoder().decode(T.self, from: data)
                completion { parsedObject }
            } catch {
                completion { throw APIResponseError.decodeError }
            }

        }.resume()
    }

    func requestImage(from url: String, completion: @escaping ImageNetworkCompletion) {
        guard let url = URL(string: url),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            completion(nil)
            return
        }
        completion(image)
    }
}
