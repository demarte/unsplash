//
//  FavoritesCoordinator.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 26/06/21.
//

import UIKit

class FavoritesCoordinator: Coordinator {
    
    // MARK: - Properties

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Initializer
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    
    func start() {
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.navigationItem.title = Localizable.favorites.localize
        favoritesViewController.showDetails = showDetails
        favoritesViewController.showConfirmationAlert = showConfirmationAlert
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(favoritesViewController, animated: false)
    }
}

extension FavoritesCoordinator {

    func showDetails(for photo: Photo) {
        let viewModel = PhotoDetailViewModel(photo: photo)
        let viewController = PhotoDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showConfirmationAlert(completion: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: nil, message: Localizable.alertDescription.localize, preferredStyle: .actionSheet)
        let destructiveAction = UIAlertAction(title: Localizable.delete.localize, style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: Localizable.cancel.localize, style: .cancel, handler: completion)
        alertController.addAction(destructiveAction)
        alertController.addAction(cancelAction)
        navigationController.present(alertController, animated: true, completion: nil)
    }
}
