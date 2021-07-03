//
//  PhotoDetailViewControllerTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 03/07/21.
//

import XCTest
@testable import Unsplash

class PhotoDetailViewControllerTests: BaseSnapshotTest {
    
    private var viewModel: PhotoDetailViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        viewModel = PhotoDetailViewModelMock()
    }
    
    override func tearDown() {
        viewModel = nil
    }

    func testViewControllerLoaded() {
        let sut = makeSUT()

        let frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)
        let window = UIWindow(frame: frame)
        window.rootViewController = sut
        window.makeKeyAndVisible()
        sut.loadViewIfNeeded()
        verifySnapshotView(delay: 1) {
            sut.view
        }
    }
    
    private func makeSUT() -> PhotoDetailViewController {
        let viewController = PhotoDetailViewController(viewModel: viewModel)
        return viewController
    }
}
