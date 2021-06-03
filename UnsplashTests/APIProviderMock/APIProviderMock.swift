//
//  APIProviderMock.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation
@testable import Unsplash

class APIProviderMock: APIProviderProtocol {

    enum State {
        case success
        case error(APIResponseError)
    }

    var state: State = .success

    func request<T>(_ type: T.Type, urlRequest: URLRequest, completion: @escaping NetworkCompletion<T>) {
        switch state {
        case .success:
            completion {
                guard let model = [Photo.fixture] as? T else {
                    throw APIResponseError.noData
                }
                return model
            }
        case .error(let error):
            completion { throw error }
        }
    }
}
