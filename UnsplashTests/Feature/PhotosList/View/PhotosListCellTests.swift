//
//  PhotosListCellTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 03/07/21.
//

import XCTest
@testable import Unsplash

class PhotosListCellTests: BaseSnapshotTest {
    
    private var viewModel: PhotosListCellViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        viewModel = PhotosListCellViewModelMock()
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testPhotoCell() {
        let sut = makeSUT(with: .success)
        verifySnapshotView(delay: 1) { sut }
    }
    
    private func makeSUT(with: PhotosListManagerMock.State) -> PhotosListCell {
        let size = CGSize(width: 100, height: 100)
        let frame = CGRect(origin: .zero, size: size)
        let view = PhotosListCell(frame: frame)
        view.setUpCell(with: viewModel)
        return view
    }
}
