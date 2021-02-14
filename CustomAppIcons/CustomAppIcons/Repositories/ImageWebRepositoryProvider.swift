//
//  ImageWebRepositoryProvider.swift
//  CustomAppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import Combine
import Foundation
import UIKit

protocol ImageWebRepositoryProvider {
    var session: URLSession { get }
    func downloadImage(at url: URL) -> AnyPublisher<UIImage, Error>
}

struct ImageDownloadWebRepository: ImageWebRepositoryProvider {
    let session: URLSession
    
    init(session: URLSession = URLSession.configuredURLSession()) {
        self.session = session
    }
    
    func downloadImage(at url: URL) -> AnyPublisher<UIImage, Error> {
        let urlRequest = URLRequest(url: url)
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) in
                guard let image = UIImage(data: data) else {
                    throw APIError.imageDownloadError
                }
                return image
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
