//
//  FavoritesViewController.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 24/06/21.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    // MARK: - Override
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let jsonList = UserDefaults.standard.array(forKey: UserDefaultsKeys.photoKey.rawValue)
        let photos = [Photo](fromJSONList: jsonList ?? [])
        print(photos)
    }
}
