//
//  FavoritesViewModelTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 27/06/21.
//

import XCTest
@testable import Unsplash

class FavoritesViewModelTests: XCTestCase {
    
    private var viewModel: FavoritesViewModelProtocol!
    
    override func setUp() {
        let provider = UserDefaultsProviderMock()
        viewModel = FavoritesViewModel(provider: provider)
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testFetchPhotos() {
        viewModel.fetchFavorites()
        XCTAssertEqual(viewModel.photos.value.count, 2)
    }
    
    func testRemoveAllPhotos() {
        viewModel.fetchFavorites()
        viewModel.deleteAllPhotos()
        XCTAssertEqual(viewModel.photos.value.count, .zero)
    }
}
