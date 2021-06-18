//
//  PhotoDetailManagerTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 17/06/21.
//

import XCTest
@testable import Unsplash

class PhotoDetailManagerTests: XCTestCase {

    private var business: PhotosListBusinessMock!
    private var manager: PhotoDetailManagerProtocol!

    override func setUp() {
        business = PhotosListBusinessMock()
        manager = PhotoDetailManager(business: business)
    }

    override func tearDown() {
        manager = nil
        business = nil
    }

    func testFetchImageSuccess() {
        manager.fetchPhotoDetails(photoURL: String()) { image in
            XCTAssertNotNil(image)
        }
    }

    func testFetchImageFailure() {
        business.state = .failure
        manager.fetchPhotoDetails(photoURL: String()) { image in
            XCTAssertNil(image)
        }
    }
}
