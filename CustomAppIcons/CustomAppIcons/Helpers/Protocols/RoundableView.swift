//
//  RoundableView.swift
//  AppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import UIKit

protocol RoundableView {
    var cornerRadius: CGFloat { get set }
    
    func setCornerRadius()
}

extension RoundableView where Self: UIView {
    func setCornerRadius() {
        layer.cornerRadius = cornerRadius
    }
}
