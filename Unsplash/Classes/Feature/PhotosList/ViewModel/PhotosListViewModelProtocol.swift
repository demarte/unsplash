//
//  PhotosListViewModelProtocol.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation

protocol PhotosListViewModelProtocol {

    var state: Dynamic<PhotosListViewModelState> { get }
    func fetch()
}