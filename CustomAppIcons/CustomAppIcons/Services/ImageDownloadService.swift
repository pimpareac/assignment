//
//  ImageDownloadService.swift
//  CustomAppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import Combine
import Foundation
import UIKit

protocol ImageDownloadServiceProvider {
    typealias DownloadCompletion = ((Result<UIImage, Error>) -> Void)
    func downloadImage(at url: URL, completion: @escaping DownloadCompletion)
}

class ImageDownloadService: ImageDownloadServiceProvider {
    private let imageRepository: ImageWebRepositoryProvider?
    private var subscriptions = Set<AnyCancellable>()
    
    init(respository: ImageWebRepositoryProvider = ImageDownloadWebRepository(session: URLSession.configuredURLSession())) {
        imageRepository = respository
    }
    
    func downloadImage(at url: URL, completion: @escaping DownloadCompletion) {
        imageRepository?.downloadImage(at: url)
            .sink(receiveCompletion: { (result) in
                switch result {
                case .finished: break
                case .failure(let error):
                    debugPrint("Error: \(error)")
                    completion(.failure(error))
                }
            }, receiveValue: { (image) in
                completion(.success(image))
            })
            .store(in: &subscriptions)
    }
}
