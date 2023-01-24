//
//  GameFavoriteCollectionViewCell.swift
//  RawGameApp
//
//  Created by kamilcal on 20.01.2023.
//

import UIKit
import SDWebImage


class GameFavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        imageView.layer.cornerRadius = 8.0
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
    }
    
    var favoriteBtn: (() -> ())?
    
    
    public func configure(with model: GameFavoriteModel) {
        guard let url = URL(string: model.backgroundImage ?? "") else { return }
        
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        imageView.sd_setImage(with: url)
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        favoriteBtn?()
        
        
    }
}
