//
//  PhotoInfoServices.swift
//  NASA APoD Viewer
//
//  Created by Ivo Dutra on 26/07/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import Foundation

// TODO: only photo as media type

protocol PhotoInfoServicesProtocol {
     func fetchPhotoInfo(onDay: String, completion: @escaping (PhotoInfo?) -> Void)
}

/// Services Layer for PhotoInfo
class PhotoInfoServices: PhotoInfoServicesProtocol {

    var baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
    /// NASA developer key
    let apiKey = "ymJRGZeMRKlbhAmjXO2cGI4rPfjTLGbyrm87EeMu"

    // MARK: - Fetch

    /// Fetch a photo on a day at the NASA Astronomy Picture of the Day API
    func fetchPhotoInfo(onDay day: String, completion: @escaping (PhotoInfo?) -> Void) {

        // This dictionary is used to construct the URL using URLComponents
        let query: [String: String] = [
            "date": day,
            "api_key": apiKey
        ]
        let url = baseURL.withQueries(query)!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            // Handle Errors
            if let error = error {
                self.handleClientError(error)
                return
            }

            // Handle Response
            // 200-299 status codes are Successful responses
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response)
                return
            }

            let jsonDecoder = JSONDecoder()

            if let data = data, let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                completion(photoInfo)
            } else {
                print("No data returned")
                completion(nil)
            }

        }

        task.resume()
    }

    // MARK: - Errors

    func handleClientError(_ error: Error) {
    
    }

    func handleServerError(_ response: URLResponse?) {

    }

}
