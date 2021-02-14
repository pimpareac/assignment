//
//  ShadowView.swift
//  AppIcons
//
//  Created by Amol Pimpare on 13/02/21.
//

import UIKit

@IBDesignable
class ShadowView: UIView, ShadowableView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.darkGray {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOffsetWidth: CGFloat = 5.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOffsetHeight: CGFloat = 5.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 4.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    private(set) lazy var shadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.insertSublayer(layer, at: 0)
        self.setNeedsLayout()
        return layer
    }()
    
    // MARK: - View LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setShadow()
        setCornerRadius()
    }
}
