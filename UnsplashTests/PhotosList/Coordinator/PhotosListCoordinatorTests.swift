//
//  PhotosListCoordinatorTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import XCTest
@testable import Unsplash

class PhotosListCoordinatorTests: XCTestCase {

    private var navigationController: UINavigationController!

    override func setUp() {
        navigationController = UINavigationController()
    }

    func testCoordinatorStart() throws {
        let coordinator = PhotosListCoordinator(navigationController: navigationController)
        coordinator.start()

        XCTAssert(navigationController.viewControllers.first is PhotosListViewController)
    }
}
