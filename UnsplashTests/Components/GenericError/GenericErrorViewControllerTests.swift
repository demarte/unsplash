//
//  GenericErrorViewControllerTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 04/07/21.
//

import XCTest
@testable import Unsplash

class GenericErrorViewControllerTests: BaseSnapshotTest {
    
    func testLoadViewController() {
        let sut = makeSUT()

        let frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)
        let window = UIWindow(frame: frame)
        window.rootViewController = sut
        window.makeKeyAndVisible()
        sut.loadViewIfNeeded()
        verifySnapshotView { sut.view }
    }
    
    private func makeSUT() -> GenericErrorViewController {
        return GenericErrorViewController()
    }
}
