//
//  PhotosListCellViewModelTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 17/06/21.
//

import XCTest
@testable import Unsplash

class PhotosListCellViewModelTests: XCTestCase {

    private var viewModel: PhotosListCellViewModel!
    private var manager: PhotosListManagerMock!

    override func setUp() {
        manager = PhotosListManagerMock()
        let photo = Photo.fixture()
        viewModel = PhotosListCellViewModel(model: photo, manager: manager)
    }

    override func tearDown() {
        manager = nil
        viewModel = nil
    }

    func testFetchImageSuccess() {
        viewModel.fetchImage()

        switch viewModel.state.value {
        case .loaded(let image):
            XCTAssertNotNil(image)
        default:
            XCTFail("Expected loaded")
        }
    }
}
