//
//  EmptyStateCellTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 03/07/21.
//

import XCTest
@testable import Unsplash

class EmptyStateCellTests: BaseSnapshotTest {
    
    func testEmptyStateCell() {
        let sut = makeSUT()
        verifySnapshotView { sut }
    }
    
    private func makeSUT() -> EmptyStateCell {
        let size = CGSize(width: 414, height: 400)
        let frame = CGRect(origin: .zero, size: size)
        let view = EmptyStateCell(frame: frame)
        view.setUp(title: Localizable.emptyStateTitle.localize, description: Localizable.emptyStateDescription.localize)
        return view
    }
}
