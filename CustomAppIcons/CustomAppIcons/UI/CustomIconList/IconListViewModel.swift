//
//  IconListViewModel.swift
//  CustomAppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import UIKit

struct CustomIconViewModel {
    let title: String
    let subTitle: String
    let imageUrl: String
}

class IconListViewModel: NSObject {
    private var webModel: CustomIconListWebModel?
    private var listService: CustomIconListService?
    
    @Published var appIconList: [CustomIconViewModel] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
    required init(with service: CustomIconListService = CustomIconListService() ) {
        self.listService = service
    }
    
    // MARK: - Network Requests
    
    /// Fetch app icons with completion handler. Completion handler is optional
    /// - Parameter completion: completion block to be called after fetch is complete.
    func fetchAppIcons(_ completion: (() -> Void)? = nil) {
        isLoading = false
        errorMessage = "No Data"
        completion?()
    }
}
