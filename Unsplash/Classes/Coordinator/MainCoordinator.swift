//
//  MainCoordinator.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 20/06/21.
//

import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    // MARK: - Initializer
    
    init(tabBarController: UITabBarController, navigationController: UINavigationController) {
        self.tabBarController = tabBarController
        self.navigationController = navigationController
    }
    
    // MARK: - Public Properties
    
    func start() {
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: .zero)
        tabBarController.viewControllers = [navigationController, favoritesViewController]
        let photosListCoordinator = PhotosListCoordinator(navigationController: navigationController)
        photosListCoordinator.start()
    }
}
