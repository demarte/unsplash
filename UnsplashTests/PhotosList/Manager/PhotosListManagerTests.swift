//
//  PhotosListManagerTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import XCTest
@testable import Unsplash

class PhotosListManagerTests: XCTestCase {

    private var business: PhotosListBusinessMock!
    private var manager: PhotosListManagerProtocol!

    override func setUp() {
        business = PhotosListBusinessMock()
        manager = PhotosListManager(business: business)
    }

    override func tearDown() {
        manager = nil
        business = nil
    }

    func testFetchPhotosSuccess() {
        manager.fetch(by: .zero) { result in
            switch result {
            case .success(let photos):
                XCTAssertEqual(photos.count, 1)
                XCTAssertEqual(photos[0].id, "nxx0N1oAnPQ")
                XCTAssertEqual(photos[0].createdAt, "2021-05-31T17:16:32-04:00")
                XCTAssertEqual(photos[0].updatedAt, "2021-06-02T07:21:33-04:00")
                XCTAssertEqual(photos[0].width, 5464)
                XCTAssertEqual(photos[0].height, 8192)
                XCTAssertEqual(photos[0].color, "#262626")
                XCTAssertEqual(photos[0].blurHash, "L8AT1T?HMy~7v|xH%4={IUIXIXxG")
                XCTAssertEqual(photos[0].likes, 3)
                XCTAssertEqual(photos[0].description, "my photo")
                XCTAssertEqual(photos[0].altDescription, "woman in blue denim jacket sitting on black metal bench")
            case .failure:
                XCTFail("Expected success")
            }
        }
    }

    func testFetchPhotosFailure() {
        business.state = .failure
        manager.fetch(by: .zero) { result in
            switch result {
            case .success:
                XCTFail("Expected failure")
            case .failure(let error):
                XCTAssertEqual(error, .noData)
            }
        }
    }
}
