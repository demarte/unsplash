//
//  PhotosListViewControllerTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 30/06/21.
//

import XCTest
@testable import Unsplash

class PhotosListViewControllerTests: BaseSnapshotTest {
    
    private var viewModel: PhotosListViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        viewModel = PhotosListViewModelMock()
    }
    
    override func tearDown() {
        viewModel = nil
    }

    func testLoadViewController() {
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
    
    private func makeSUT() -> PhotosListViewController {
        let viewController = PhotosListViewController(viewModel: viewModel)
        return viewController
    }
}
