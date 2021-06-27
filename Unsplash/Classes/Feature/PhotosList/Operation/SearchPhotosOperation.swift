//
//  SearchPhotosOperation.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 27/06/21.
//

import Foundation

final class SearchPhotosOperation: AsyncOperation {

    // MARK: - Constants

    private enum Constants {
        static let searchPath: String = "search"
        static let photosPath: String = "photos"
        static let clientIdKey = "client_id"
        static let perPageKey = "per_page"
        static let pageCount = "30"
        static let queryKey = "query"
    }
    // MARK: - Public Properties

    var photosListResult: Result<[Photo], APIResponseError>?

    // MARK: - Private Properties

    private let searchTerm: String
    private let business: PhotosListBusinessProtocol

    // MARK: - Initializer

    init(searchTerm: String, business: PhotosListBusinessProtocol) {
        self.searchTerm = searchTerm
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
        business.searchPhotos(with: createURLRequest()) { [weak self] result in
            guard let self = self else { return }
            self.photosListResult = result
            self.finish()
        }
    }

    private func createURLRequest() -> URLRequest {
        var url = Server.url
        url.appendPathComponent(Constants.searchPath)
        url.appendPathComponent(Constants.photosPath)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = [
            URLQueryItem(name: Constants.clientIdKey, value: Server.apiKey),
            URLQueryItem(name: Constants.perPageKey, value: Constants.pageCount),
            URLQueryItem(name: Constants.queryKey, value: searchTerm)
        ]
        urlComponents?.queryItems = queryItems
        let urlRequest = URLRequest(url: (urlComponents?.url)!)

        return urlRequest
    }
}
