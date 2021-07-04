//
//  Coordinator.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

extension Coordinator {
    
    func presentGenericError() {
        let genericErrorViewController = GenericErrorViewController()
        genericErrorViewController.modalPresentationStyle = .formSheet
        navigationController.present(genericErrorViewController, animated: true, completion: nil)
    }
}
