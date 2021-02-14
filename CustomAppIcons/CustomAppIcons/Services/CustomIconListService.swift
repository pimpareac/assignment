//
//  CustomIconListService.swift
//  CustomAppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import Foundation

protocol CustomIconListProvider {
    typealias FetchCompletion = ((Result<[AppIcon], Error>) -> Void)

    func fetchAppIcons(_ completion: @escaping FetchCompletion)
}

struct CustomIconListService: CustomIconListProvider {
    
    func fetchAppIcons(_ completion: @escaping FetchCompletion) {
        // TODO: - Integrate network call
    }
}
