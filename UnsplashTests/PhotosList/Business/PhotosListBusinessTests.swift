//
//  PhotosListBusinessTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 17/06/21.
//

import XCTest
@testable import Unsplash

class PhotosListBusinessTests: XCTestCase {

    private var provider: APIProviderMock!
    private var business: PhotosListBusinessProtocol!

    override func setUp() {
        provider = APIProviderMock()
        business = PhotosListBusiness(provider: provider)
    }

    override func tearDown() {
        provider = nil
        business = nil
    }

    func testFetchPhotosSuccess() {
        business.fetchPhotos(with: nil) { result in
            switch result {
            case.success(let photos):
                XCTAssertEqual(photos.count, 1)
            case .failure:
                XCTFail("Expected success")
            }
        }
    }

    func testFetchPhotosFailure() {
        provider.state = .error(.invalidResponse)
        business.fetchPhotos(with: nil) { result in
            switch result {
            case.success:
                XCTFail("Expected success")
            case .failure(let error):
                XCTAssertEqual(error, .invalidResponse)
            }
        }
    }

    func testFetchImageSuccess() {
        business.fetchImage(by: String()) { image in
            XCTAssertNotNil(image)
        }
    }

    func testFetchImageFailure() {
        provider.state = .error(.invalidResponse)
        business.fetchImage(by: String()) { image in
            XCTAssertNil(image)
        }
    }
}
