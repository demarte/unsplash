//
//  PhotoDetailViewModelProtocol.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation

protocol PhotoDetailViewModelProtocol {

    var state: Dynamic<PhotoDetailViewModelState> { get }

    func fetchPhotoDetails()
    func savePhoto()
    func removePhoto()
    func checkIfImageIsSaved() -> Bool
}
