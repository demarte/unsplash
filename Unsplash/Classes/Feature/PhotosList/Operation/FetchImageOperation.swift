//
//  FetchImageOperation.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation
import UIKit

class FetchImageOperation: AsyncOperation {

    // MARK: - Properties

    private let urlString: String
    private let completion: FetchImageCompletion

    // MARK: - Initializer

    init(urlString: String, completion: @escaping FetchImageCompletion) {
        self.urlString = urlString
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
        guard let url = URL(string: urlString),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            completion(nil)
            finish()
            return
        }
        completion(image)
        finish()
    }
}
