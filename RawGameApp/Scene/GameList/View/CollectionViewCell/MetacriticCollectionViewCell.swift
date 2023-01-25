//
//  MetacriticCollectionViewCell.swift
//  RawGameApp
//
//  Created by kamilcal on 22.01.2023.
//

import UIKit
import SDWebImage

class MetacriticCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var metacriticShadowView: UIView!
    @IBOutlet weak var metacriticImageView: UIImageView!
    @IBOutlet weak var metacriticTitleLabel: UILabel!
        
    //MARK: - Lifecycle Functions

    override func awakeFromNib() {
        super.awakeFromNib()
        metacriticShadowView.addRoundedCorners()
        metacriticShadowView.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        metacriticImageView.addRoundedCorners()
    }
//MARK: - Configure Functions

    public func configure(with model: ResultGame) {
        guard let url = URL(string: model.backgroundImage ?? "") else { return }
        
        metacriticImageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        metacriticImageView.sd_setImage(with: url)
        metacriticTitleLabel.text = model.name
    }
    
}
