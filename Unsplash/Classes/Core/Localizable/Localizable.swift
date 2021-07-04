//
//  Localizable.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 27/06/21.
//

import Foundation

enum Localizable: String {

    static let tableName: String = "Localizable"
    
    case favorites
    case delete
    case cancel
    case alertDescription
    case emptyStateTitle
    case emptyStateDescription
    case unsplash
    case placeholder
    case notFound
    case noConnection
    case genericErrorTitle
    case genericErrorDescription
    
    var localize: String {
        NSLocalizedString(self.rawValue, tableName: Localizable.tableName, bundle: .main, value: String(), comment: String())
    }
}
