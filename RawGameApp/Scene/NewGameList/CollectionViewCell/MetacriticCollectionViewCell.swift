//
//  MetacriticCollectionViewCell.swift
//  RawGameApp
//
//  Created by kamilcal on 22.01.2023.
//

import UIKit

class MetacriticCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var metacriticShadowView: UIView!
    @IBOutlet weak var metacriticImageView: UIImageView!
    @IBOutlet weak var metacriticTitleLabel: UILabel!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        metacriticShadowView.addRoundedCorners()
        metacriticShadowView.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        metacriticImageView.addRoundedCorners()
    }
    
}
