//
//  RoundedImageView.swift
//  AppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import UIKit

@IBDesignable
class RoundedImageView: UIImageView, RoundableView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
}
