//
//  LoadingCellTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 03/07/21.
//

import XCTest
@testable import Unsplash

class LoadingCellTests: BaseSnapshotTest {
    
    func testLoadingCell() {
        let sut = makeSUT()
        verifySnapshotView { sut }
    }
    
    private func makeSUT() -> LoadingCell {
        let size = CGSize(width: 414, height: 100)
        let frame = CGRect(origin: .zero, size: size)
        let view = LoadingCell(frame: frame)
        view.startLoading()
        return view
    }
}
