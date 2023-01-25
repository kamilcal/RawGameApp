//
//  PopularCollectionViewCell.swift
//  RawGameApp
//
//  Created by kamilcal on 21.01.2023.
//

import UIKit
import SDWebImage

class PopularCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var backImageView: UIView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var popularGradientView: UIView!
    @IBOutlet var popularTitleLabel: UILabel!
    @IBOutlet var populargenreLabel: UILabel!
    
    var id: String?

//MARK: - Lifecycle Functions

    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.addRoundedCorners()
        backImageView.addShadow()
        backImageView.layer.shadowPath = UIBezierPath(roundedRect: posterImageView.bounds, cornerRadius: 8).cgPath
        
        popularGradientView.setGradientBackground(colorTop: UIColor.clear, colorBottom: UIColor.black)
        popularGradientView.clipsToBounds = true
        popularGradientView.layer.cornerRadius = 7
        popularGradientView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
//MARK: - Configure Functions

    public func configure(with model: ResultGame) {
        guard let url = URL(string: model.backgroundImage ?? "") else { return }
        
        posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        posterImageView.sd_setImage(with: url)
        populargenreLabel.text = model.genres.first?.name
        popularTitleLabel.text = model.name
        id = String(model.id)
    }
}
