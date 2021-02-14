//
//  CustomIconListService.swift
//  CustomAppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import Combine
import Foundation

protocol CustomIconListProvider {
    typealias FetchCompletion = ((Result<CustomIconListWebModel, Error>) -> Void)
    
    func fetchAppIcons(_ completion: @escaping FetchCompletion)
}

class CustomIconListService: CustomIconListProvider {
    private static let baseURL = "https://irapps.github.io"
    
    private let webRepository: CustomIconListWebRepositoryProvider?
    private var subscriptions = Set<AnyCancellable>()
    
    init(respository: CustomIconListWebRepositoryProvider = CustomIconListWebRepository(session: URLSession.configuredURLSession(), baseURL: baseURL)) {
        webRepository = respository
    }
    
    func fetchAppIcons(_ completion: @escaping FetchCompletion) {
        webRepository?.fetchAppIcons()
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished: break
                case .failure(let error):
                    debugPrint("Error: \(error)")
                    completion(.failure(error))
                }
            } receiveValue: { (webModel) in
                completion(.success(webModel))
            }
            .store(in: &subscriptions)
    }
}
