//
//  PhotosListViewModelMock.swift
//  UnsplashTests
//
//  Created by Ivan Rodrigues de Martino on 30/06/21.
//

import Foundation
@testable import Unsplash

class PhotosListViewModelMock: PhotosListViewModelProtocol {
    
    var state = Dynamic<PhotosListViewModelState>(.loading)
    var isFetching = Dynamic<Bool>(false)
    var currentPage: Int = .zero
    var isFiltering: Bool = false
        
    private var mockData: [Photo] {
        return [
            Photo.fixture(urls: PhotoURL.fixture(regular: nil,
                                                 small: "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg&w=400&fit=max",
                                                 thumb: nil))
        ]
    }
    
    private var viewModelCells: [PhotosListCellViewModelProtocol] {
        return [
            PhotosListCellViewModelMock()
        ]
    }
    
    func fetch() {
        state.value = .loaded(mockData)
    }
    
    func searchPhotos(by searchTerm: String) { }
}
