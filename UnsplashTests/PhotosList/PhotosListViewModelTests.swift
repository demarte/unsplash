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

    func testFetchPhotosSuccess() {
        viewModel.fetch()
    }
}
