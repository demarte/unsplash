//
//  PhotosListCellViewModelProtocol.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 03/06/21.
//

import Foundation

protocol PhotosListCellViewModelProtocol {

    var state: Dynamic<PhotosListCellViewModelState> { get }

    func fetchImage()
}
