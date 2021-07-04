//
//  ConnectionErrorViewTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 03/07/21.
//

import XCTest
@testable import Unsplash

class ConnectionErrorViewTests: BaseSnapshotTest {
    
    func testConnectionView() {
        let sut = makeSUT()
        verifySnapshotView { sut }
    }
    
    private func makeSUT() -> ConnectionErrorView {
        let size = CGSize(width: 414, height: 70.0)
        let frame = CGRect(origin: .zero, size: size)
        let view = ConnectionErrorView(frame: frame)
        view.setUp(title: Localizable.noConnection.localize)
        return view
    }
}
