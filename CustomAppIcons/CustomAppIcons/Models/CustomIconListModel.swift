//
//  CustomIconListWebModel.swift
//  CustomAppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import Foundation

struct CustomIconListWebModel: Codable {
    let icons: [AppIcon]
    
    struct AppIcon: Codable {
        let title: String
        let subtitle: String
        let image: String
    }
}
