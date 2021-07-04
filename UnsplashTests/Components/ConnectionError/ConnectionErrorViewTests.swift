//
//  ConnectionErrorViewTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 03/07/21.
//

import XCTest
@testable import Unsplash

class ConnectionErrorViewTests: BaseSnapshotTest {
    
    func testLoadingView() {
        let sut = makeSUT()
        verifySnapshotView { sut }
    }
    
    private func makeSUT() -> ConnectionErrorView {
        let size = CGSize(width: 414, height: 180.0)
        let frame = CGRect(origin: .zero, size: size)
        let view = ConnectionErrorView(frame: frame)
        view.setUpView(with: Localizable.noConnection.localize)
        return view
    }
}
