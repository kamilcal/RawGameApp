//
//  UpcomingCollectionViewCell.swift
//  RawGameApp
//
//  Created by kamilcal on 22.01.2023.
//

import UIKit
import SDWebImage

class UpcomingCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var wrapView: UIView!
    @IBOutlet weak var upcomingImageView: UIImageView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var upcomingTitleLabel: UILabel!
    
//MARK: - Lifecycle Functions

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
//MARK: - SetupUI

    func setupViews() {
        upcomingImageView.addRoundedCorners()
        wrapView.addShadow()
        
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 7
        blurView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
//MARK: - Configure Functions

    public func configure(with model: ResultGame) {
        guard let url = URL(string: model.backgroundImage ?? "") else { return }
        
        upcomingImageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        upcomingImageView.sd_setImage(with: url)
        upcomingTitleLabel.text = model.name
    }

}
