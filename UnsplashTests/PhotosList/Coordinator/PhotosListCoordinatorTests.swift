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

    func testCoordinatorStart() {
        let coordinator = PhotosListCoordinator(navigationController: navigationController)
        coordinator.start()

        XCTAssert(navigationController.viewControllers.first is PhotosListViewController)
    }

    func testShowDetails() {
        let coordinator = PhotosListCoordinator(navigationController: navigationController)
        coordinator.showDetails(for: Photo.fixture())

        XCTAssert(navigationController.viewControllers.first is PhotoDetailViewController)
    }
}
