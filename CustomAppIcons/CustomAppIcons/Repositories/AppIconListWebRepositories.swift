//
//  AppIconListWebRepositories.swift
//  AppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import Combine
import Foundation

protocol CustomIconListWebRepositoryProvider: WebRepository {
    func fetchAppIcons() -> AnyPublisher<CustomIconListWebModel, Error>
}

struct CustomIconListWebRepository: CustomIconListWebRepositoryProvider {
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func fetchAppIcons() -> AnyPublisher<CustomIconListWebModel, Error> {
        return call(endpoint: API.fetchAppIcons)
    }
}

// MARK: - API Endpoints

extension CustomIconListWebRepository {
    private static let iconsDataEndpoint = "/wzpsolutions/tests/ios-custom-icons/IconsData.json"
    
    enum API: APICall {
        case fetchAppIcons
        
        var path: String  {
            switch self {
            case .fetchAppIcons:
                return iconsDataEndpoint
            }
        }
    }
}
