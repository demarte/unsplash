//
//  PhotoDetailViewModelTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 17/06/21.
//

import XCTest
@testable import Unsplash

class PhotoDetailViewModelTests: XCTestCase {

    private var photo: Photo!
    private var provider: UserDefaultsProviderMock!
    private var manager: PhotoDetailManagerMock!
    private var viewModel: PhotoDetailViewModelProtocol!

    override func setUp() {
        photo = Photo.fixture(id: "1", urls: PhotoURL.fixture(full: String()))
        provider = UserDefaultsProviderMock()
        manager = PhotoDetailManagerMock()
        viewModel = PhotoDetailViewModel(photo: photo, manager: manager, provider: provider)
    }

    override func tearDown() {
        photo = nil
        provider = nil
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
    
    func testSavePhoto() {
        viewModel.savePhoto()
        XCTAssert(provider.photos.contains(photo))
    }
    
    func testRemovePhoto() {
        viewModel.savePhoto()
        viewModel.removePhoto()
        XCTAssertFalse(provider.photos.contains(photo))
    }
    
    func testCheckIfImageIsSaved() {
        viewModel.savePhoto()
        XCTAssert(viewModel.checkIfImageIsSaved())
    }
}
