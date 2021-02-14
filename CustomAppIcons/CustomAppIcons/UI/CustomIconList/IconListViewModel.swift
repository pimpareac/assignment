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
    @Published var appIconList: [CustomIconViewModel] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
    private var webModel: CustomIconListWebModel?
    private var listService: CustomIconListService?
    
    // MARK: - Init
    
    required init(with service: CustomIconListService = CustomIconListService() ) {
        self.listService = service
    }
    
    // MARK: - Network Request
    
    /// Fetch app icons with completion handler. Completion handler is optional
    func fetchAppIcons() {
        listService?.fetchAppIcons { [weak self] (result) in
            switch result {
            case .success(let webModel):
                self?.handleSucees(with: webModel)
            case .failure(let error):
                self?.handle(error: error)
            }
        }
    }
    
    private func handleSucees(with webModel: CustomIconListWebModel) {
        appIconList = webModel.icons.compactMap {
            CustomIconViewModel(title: $0.title,
                                subTitle: $0.subtitle,
                                imageUrl: $0.image)
        }
        
        errorMessage = nil
        isLoading = false
    }
    
    private func handle(error: Error) {
        errorMessage = error.localizedDescription
        isLoading = false
        appIconList = []
    }
}
