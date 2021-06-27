//
//  PhotosListBusiness.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 17/06/21.
//

import Foundation
import UIKit

final class PhotosListBusiness: PhotosListBusinessProtocol {

    // MARK: - Private Properties

    private let provider: APIProviderProtocol

    // MARK: - Initializer

    init(provider: APIProviderProtocol = APIProvider()) {
        self.provider = provider
    }

    // MARK: - Public Methods

    func fetchPhotos(with request: URLRequest?, completion: @escaping FetchPhotosCompletion<[Photo]>) {
        provider.request([Photo].self, urlRequest: request) { [weak self] response in
            guard let self = self else { return }
            do {
                let result = try response()
                completion(.success(result))
            } catch {
                completion(.failure(self.handleError(error)))
            }
        }
    }
    
    func searchPhotos(with request: URLRequest?, completion: @escaping FetchPhotosCompletion<[Photo]>) {
        provider.request(PhotoResult.self, urlRequest: request) { [weak self] response in
            guard let self = self else { return }
            do {
                let result = try response()
                completion(.success(result.results))
            } catch {
                completion(.failure(self.handleError(error)))
            }
        }
    }

    // MARK: - Private Methods

    private func handleError(_ error: Error) -> APIResponseError {
        guard let apiError = error as? APIResponseError else { return .invalidResponse }
        return apiError
    }
}
