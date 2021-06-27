//
//  PhotosListViewModelTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import XCTest
@testable import Unsplash

class PhotosListViewModelTests: XCTestCase {

    private var viewModel: PhotosListViewModel!
    private var manager: PhotosListManagerMock!

    override func setUp() {
        manager = PhotosListManagerMock()
        viewModel = PhotosListViewModel(manager: manager)
    }

    override func tearDown() {
        manager = nil
        viewModel = nil
    }

    func testFetchPhotosSuccess() {
        viewModel.fetch()
        switch viewModel.state.value {
        case .loaded(let photos):
            XCTAssertEqual(photos.count, 1)
            XCTAssertEqual(photos[0].id, "nxx0N1oAnPQ")
            XCTAssertEqual(photos[0].createdAt, "2021-05-31T17:16:32-04:00")
            XCTAssertEqual(photos[0].updatedAt, "2021-06-02T07:21:33-04:00")
            XCTAssertEqual(photos[0].width, 5464)
            XCTAssertEqual(photos[0].height, 8192)
            XCTAssertEqual(photos[0].color, "#262626")
            XCTAssertEqual(photos[0].blurHash, "L8AT1T?HMy~7v|xH%4={IUIXIXxG")
            XCTAssertEqual(photos[0].description, "my photo")
            XCTAssertEqual(photos[0].altDescription, "woman in blue denim jacket sitting on black metal bench")
        default:
            XCTFail("Expected loaded")
        }
    }

    func testFetchPhotosFailure() {
        manager.state = .failure
        viewModel.fetch()
        switch viewModel.state.value {
        case .error(let error):
            XCTAssertEqual(error, .invalidResponse)
        default:
            XCTFail("Expected Failure")
        }
    }
}
