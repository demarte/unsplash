//
//  APIProviderMock.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation
import UIKit
@testable import Unsplash

class APIProviderMock: APIProviderProtocol {

    enum State {
        case success
        case error(APIResponseError)
    }

    var state: State = .success

    func request<T>(_ type: T.Type, urlRequest: URLRequest?, completion: @escaping NetworkCompletion<T>) {
        switch state {
        case .success:
            let photo = Photo.fixture()
            guard let model = [photo] as? T else { completion { throw APIResponseError.noData }; return }
            completion { model }
        case .error(let error):
            completion { throw error }
        }
    }

    func requestImage(from url: String, completion: @escaping ImageNetworkCompletion) {
        switch state {
        case .success:
            completion(UIImage())
        case .error:
            completion(nil)
        }
    }
}
