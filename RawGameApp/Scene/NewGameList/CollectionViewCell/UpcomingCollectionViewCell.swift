//
//  UpcomingCollectionViewCell.swift
//  RawGameApp
//
//  Created by kamilcal on 22.01.2023.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var wrapView: UIView!
    @IBOutlet weak var upcomingImageView: UIImageView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var upcomingTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        upcomingImageView.addRoundedCorners()
        wrapView.addShadow()
        
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 7
        blurView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}
