//
//  CustomIconsTableViewCell.swift
//  AppIcons
//
//  Created by Amol Pimpare on 13/02/21.
//

import Combine
import UIKit

class CustomIconsTableViewCell: UITableViewCell {
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subTitleLabel: UILabel!
    @IBOutlet private var iconImageView: RoundedImageView!
    
    private var cancellables: Set<AnyCancellable> = []
    
    var viewModel: CustomIconViewModel? {
        didSet {
            bind()
        }
    }
    
    private func bind() {
        viewModel?.$image.sink { [weak self] image in
            self?.updateIcon(with: image)
        }
        .store(in: &cancellables)
    }
    
    private func updateIcon(with image: UIImage?) {
        let renderRect = CGRect(origin: .zero,
                                size: iconImageView.bounds.size)
        
        iconImageView.image = image?.rounded(withCornerRadius: 10, renderRect: renderRect)
    }
        
    // MARK: - Setup
    
    func updateCell(with viewModel: CustomIconViewModel) {
        titleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
        
        self.viewModel = viewModel
        self.viewModel?.dowloadImageIfNeeded()
    }
}
