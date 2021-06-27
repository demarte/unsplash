//
//  FavoritesCoordinatorTests.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 27/06/21.
//

import XCTest
@testable import Unsplash

class FavoritesCoordinatorTests: XCTestCase {

    private var navigationController: UINavigationController!

    override func setUp() {
        navigationController = UINavigationController()
    }

    func testCoordinatorStart() {
        let coordinator = FavoritesCoordinator(navigationController: navigationController)
        coordinator.start()

        XCTAssert(navigationController.viewControllers.first is FavoritesViewController)
    }

    func testShowDetails() {
        let coordinator = FavoritesCoordinator(navigationController: navigationController)
        coordinator.showDetails(for: Photo.fixture())

        XCTAssert(navigationController.viewControllers.first is PhotoDetailViewController)
    }
}
