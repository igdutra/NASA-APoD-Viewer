//
//  PhotoInfo.swift
//  NASA APoD Viewer
//
//  Created by Ivo Dutra on 26/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import Foundation

/*
Based on the book “App Development with Swift.” Apple Inc. - Education, 2019. Apple Books.
https://books.apple.com/br/book/app-development-with-swift/id1465002990?l=en
*/

/// Struct based on the NASA APoD API.
/// "hdurl" and "service_version" keys were left out.
/// Copyright is returned if the image is not public domain.
struct PhotoInfo: Codable {
    var date: String
    var description: String
    var mediaType: String
    var title: String
    var url: URL
    var copyright: String?

    enum CodingKeys: String, CodingKey {
        case date
        case description = "explanation"
        case mediaType = "media_type"
        case title
        case url
        case copyright
    }
 
    // Init is called so that we can ignore the extraneous key/value pairs in the data that PhotoInfo will not include
    // Keys "hdurl" and "service_version" are not used.
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)

        self.date = try valueContainer.decode(String.self, forKey: CodingKeys.date)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.mediaType = try valueContainer.decode(String.self, forKey: CodingKeys.mediaType)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
    }
}
