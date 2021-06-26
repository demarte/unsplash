//
//  Array+JSONList.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 26/06/21.
//

import Foundation

extension Array where Element == Photo {
    
    var asJSONList: [Data] {
        return self.compactMap { $0.json }
    }
    
    init(fromJSONList jsonList: [Any?]) {
        self.init()
        for json in jsonList {
            if let data = json as? Data, let photo = Photo(json: data) {
                self.append(photo)
            }
        }
    }
}
