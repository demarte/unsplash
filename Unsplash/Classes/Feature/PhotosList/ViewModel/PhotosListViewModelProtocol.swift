//
//  PhotosListViewModelProtocol.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 01/06/21.
//

import Foundation

protocol PhotosListViewModelProtocol {

    var state: Dynamic<PhotosListViewModelState> { get }
    var isFetching: Dynamic<Bool> { get }
    var currentPage: Int { get }
    var isFiltering: Bool { get }

    func fetch()
    func searchPhotos(by searchTerm: String)
}
