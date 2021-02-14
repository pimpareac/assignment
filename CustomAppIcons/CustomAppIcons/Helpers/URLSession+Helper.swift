//
//  URLSession+Helper.swift
//  CustomAppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import Foundation

extension URLSession {
    static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
}
