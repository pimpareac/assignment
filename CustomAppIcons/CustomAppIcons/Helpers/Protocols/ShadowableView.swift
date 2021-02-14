//
//  ShadowableView.swift
//  AppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import UIKit

protocol ShadowableView: RoundableView {
    var cornerRadius: CGFloat { get set }
    var shadowColor: UIColor { get set }
    var shadowOffsetWidth: CGFloat { get set }
    var shadowOffsetHeight: CGFloat { get set }
    var shadowOpacity: Float { get set }
    var shadowRadius: CGFloat { get set }
        
    func setShadow()
}

extension ShadowableView where Self: UIView {
    func setCornerRadius() {
        layer.cornerRadius = cornerRadius
    }
    
    func setShadow() {
        let path = UIBezierPath(roundedRect: bounds,
                                cornerRadius: cornerRadius).cgPath
        layer.backgroundColor = backgroundColor?.cgColor
        layer.shadowColor = shadowColor.cgColor
        layer.shadowPath = path
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
