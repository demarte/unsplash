//
//  PhotosListOperation.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation

class PhotosListOperation: AsyncOperation {

    // MARK: - Constants

    private enum Constants {
        static let path: String = "photos"
        static let clientIdKey = "client_id"
    }

    // MARK: - Properties

    private let provider: APIProvider
    private let completion: FetchPhotosCompletion<[Photo]>

    // MARK: - Initializer

    init(provider: APIProvider = APIProvider(), completion: @escaping FetchPhotosCompletion<[Photo]>) {
        self.provider = provider
        self.completion = completion
        super.init()
    }

    // MARK: - Override

    override func main() {
        super.main()
        request()
    }

    // MARK: - Private Methods

    private func request() {
        provider.request([Photo].self, urlRequest: createURLRequest()) { [weak self] response in
            guard let self = self else { return }
            do {
                let result = try response()
                self.completion(.success(result))
            } catch {
                if let apiError = error as? APIResponseError {
                    self.completion(.failure(apiError))
                } else {
                    self.completion(.failure(.invalidResponse))
                }
            }
            self.finish()
        }
    }

    private func createURLRequest() -> URLRequest {
        var url = Server.url
        url.appendPathComponent(Constants.path)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = [URLQueryItem(name: Constants.clientIdKey, value: Server.apiKey)]
        urlComponents?.queryItems = queryItems
        let urlRequest = URLRequest(url: (urlComponents?.url)!)

        return urlRequest
    }
}
