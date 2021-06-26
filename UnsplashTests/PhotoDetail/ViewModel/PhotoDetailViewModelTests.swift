//
//  PhotoDetailViewModelTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 17/06/21.
//

import XCTest
@testable import Unsplash

class PhotoDetailViewModelTests: XCTestCase {

    private var manager: PhotoDetailManagerMock!
    private var viewModel: PhotoDetailViewModelProtocol!

    override func setUp() {
        let photo = Photo.fixture(urls: PhotoURL.fixture(full: String()))
        manager = PhotoDetailManagerMock()
        viewModel = PhotoDetailViewModel(photo: photo, manager: manager)
    }

    override func tearDown() {
        manager = nil
        viewModel = nil
    }

    func testFetchPhotoDetailsSuccess() {
        viewModel.fetchPhotoDetails()

        switch viewModel.state.value {
        case .loaded(let image):
            XCTAssertNotNil(image)
        default:
            XCTFail("Expected loaded")
        }
    }

    func testFetchPhotoDetailsFailure() {
        manager.state = .failure
        viewModel.fetchPhotoDetails()

        switch viewModel.state.value {
        case .loaded, .loading:
            XCTFail("Expected error")
        case .error:
            XCTAssert(true)
        }
    }
}
