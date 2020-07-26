//
//  URL+Extension.swift
//  NASA APoD Viewer
//
//  Created by Ivo Dutra on 26/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import Foundation

extension URL {

    /// Add to the base URL its query Items as URLComponents, by simply passing the [String: String] dictionary
    func withQueries(_ queries: [String: String]) -> URL? {

        // URLComponents you parse, read, or create all the different parts of a URL in a safe, accurate way
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)

        components?.queryItems = queries.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }

        return components?.url
    }
}
