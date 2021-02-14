//
//  UIImage+Helper.swift
//  AppIcons
//
//  Created by Amol Pimpare on 14/02/21.
//

import UIKit

extension UIImage {
    /// Create image with rounded corners
    /// - Parameters:
    ///   - radius: corner radius
    ///   - renderRect: renderable rect
    /// - Returns: Creates and retruns image with given renderable rect and corner radius
    func rounded(withCornerRadius radius: CGFloat,
                 renderRect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: renderRect.size)
        let rounded = renderer.image { ctx in
            let path = UIBezierPath(roundedRect: renderRect, cornerRadius: radius)
            ctx.cgContext.addPath(path.cgPath)
            ctx.cgContext.clip()
            
            self.draw(in: renderRect)
        }
        
        return rounded
    }
}
