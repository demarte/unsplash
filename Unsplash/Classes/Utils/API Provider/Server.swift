//
//  Server.swift
//  Unsplash
//
//  Created by Ivan Rodrigues de Martino on 02/06/21.
//

import Foundation

enum Server {

    static var url: URL {
        guard let serverURL = Bundle.main.object(forInfoDictionaryKey: "Server URL") as? String else {
            fatalError("Could not fetch URL from Info.plist")
        }
        return URL(string: serverURL)!
    }

    static var apiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API Key") as? String else {
            fatalError("Could not fetch API Key from Info.plist")
        }
        return apiKey
    }
}
