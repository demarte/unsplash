//
//  PhotosListOperation.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation

final class PhotosListOperation: AsyncOperation {

    // MARK: - Constants

    private enum Constants {
        static let path: String = "photos"
        static let clientIdKey = "client_id"
        static let perPageKey = "per_page"
        static let pageKey = "page"
        static let pageCount = "20"
    }
    // MARK: - Public Properties

    var photosListResult: Result<[Photo], APIResponseError>?

    // MARK: - Private Properties

    private let pageNumber: Int
    private let business: PhotosListBusinessProtocol

    // MARK: - Initializer

    init(pageNumber: Int, business: PhotosListBusinessProtocol) {
        self.pageNumber = pageNumber
        self.business = business
        super.init()
    }

    // MARK: - Override

    override func main() {
        super.main()
        request()
    }

    // MARK: - Private Methods

    private func request() {
        business.fetchPhotos(with: createURLRequest()) { [weak self] result in
            guard let self = self else { return }
            self.photosListResult = result
            self.finish()
        }
    }

    private func createURLRequest() -> URLRequest {
        var url = Server.url
        url.appendPathComponent(Constants.path)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = [
            URLQueryItem(name: Constants.clientIdKey, value: Server.apiKey),
            URLQueryItem(name: Constants.perPageKey, value: Constants.pageCount),
            URLQueryItem(name: Constants.pageKey, value: String(pageNumber))
        ]
        urlComponents?.queryItems = queryItems
        let urlRequest = URLRequest(url: (urlComponents?.url)!)

        return urlRequest
    }
}
