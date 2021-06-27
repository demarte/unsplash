//
//  MainCoordinator.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 20/06/21.
//

import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: - Public Properties
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    // MARK: - Private Properties
    
    let photosListNavController: UINavigationController
    let favoritesNavController: UINavigationController
    
    // MARK: - Initializer
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
        self.photosListNavController = UINavigationController()
        self.favoritesNavController = UINavigationController()
    }
    
    // MARK: - Public Properties
    
    func start() {
        startPhotosList()
        startFavorites()
        tabBarController.viewControllers = [photosListNavController, favoritesNavController]
        navigationController.viewControllers = [tabBarController]
        navigationController.isNavigationBarHidden = true
    }
    
    // MARK: - Private Methods

    private func startPhotosList() {
        photosListNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: .zero)
        
        let photosListCoordinator = PhotosListCoordinator(navigationController: photosListNavController)
        photosListCoordinator.start()
    }
    
    private func startFavorites() {
        favoritesNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavController)
        favoritesCoordinator.start()
    }
}
