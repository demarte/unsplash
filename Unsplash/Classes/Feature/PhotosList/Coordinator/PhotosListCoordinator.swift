//
//  PhotosListCoordinator.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import UIKit

class PhotosListCoordinator: Coordinator {

    // MARK: - Properties

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    // MARK: - Initializers

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public Methods

    func start() {
        let viewModel = PhotosListViewModel()
        let viewController = PhotosListViewController(viewModel: viewModel)
        viewController.showDetails = showDetails
        viewController.navigationItem.title = "Unsplash"
        viewController.navigationItem.largeTitleDisplayMode = .automatic
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension PhotosListCoordinator {

    func showDetails(for photo: Photo) {
        let viewModel = PhotoDetailViewModel(photo: photo)
        let viewController = PhotoDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
