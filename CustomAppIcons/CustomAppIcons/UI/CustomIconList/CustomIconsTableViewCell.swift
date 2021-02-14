//
//  CustomIconsTableViewCell.swift
//  AppIcons
//
//  Created by Amol Pimpare on 13/02/21.
//

import UIKit

class CustomIconsTableViewCell: UITableViewCell {
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subTitleLabel: UILabel!
    @IBOutlet private var iconImageView: RoundedImageView!
    
    private var viewModel: CustomIconViewModel?
    
    // MARK: - Setup
    
    func updateCell(with viewModel: CustomIconViewModel) {
        titleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
        
        let renderRect = CGRect(origin: .zero,
                                size: iconImageView.bounds.size)
        if let image = UIImage(named: "place_holder") {
            let rounded = image.rounded(withCornerRadius: iconImageView.cornerRadius,
                                        renderRect: renderRect)
            iconImageView.image = rounded
        }
        
        self.viewModel = viewModel
    }
}
