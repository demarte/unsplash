//
//  PhotosListCoordinator.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import UIKit

class PhotosListCoordinator: Coordinator {

    // MARK: - Public Properties

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
        viewController.presentGenericError = presentGenericError
        viewController.showDetails = showDetails
        viewController.navigationItem.title = Localizable.unsplash.localize
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension PhotosListCoordinator {

    func showDetails(for photo: Photo) {
        let viewModel = PhotoDetailViewModel(photo: photo)
        let viewController = PhotoDetailViewController(viewModel: viewModel)
        viewController.presentGenericError = presentPhotoDetailsGenericError
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentPhotoDetailsGenericError() {
        let genericErrorViewController = GenericErrorViewController()
        genericErrorViewController.modalPresentationStyle = .overFullScreen
        genericErrorViewController.dismissModal = backToRoot
        navigationController.present(genericErrorViewController, animated: true, completion: nil)
    }
    
    private func backToRoot() {
        navigationController.dismiss(animated: true, completion: nil)
        navigationController.popToRootViewController(animated: true)
    }
}
