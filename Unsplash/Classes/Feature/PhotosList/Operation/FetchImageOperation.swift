//
//  FetchImageOperation.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation
import UIKit

class FetchImageOperation: AsyncOperation {

    // MARK: - Public Properties

    var image: UIImage?

    // MARK: - Private Properties

    private let urlString: String
    private let business: PhotosListBusinessProtocol

    // MARK: - Initializer

    init(urlString: String, business: PhotosListBusinessProtocol) {
        self.urlString = urlString
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
        business.fetchImage(by: urlString) { [weak self] image in
            guard let self = self else { return }
            self.image = image
            self.finish()
        }
    }
}
