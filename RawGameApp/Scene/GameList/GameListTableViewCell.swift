//
//  GameListTableViewCell.swift
//  RawGameApp
//
//  Created by kamilcal on 18.01.2023.
//

import UIKit
import SDWebImage

class GameListTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(with model: ResultGame) {
        guard let url = URL(string: model.backgroundImage ?? "") else { return }
        
        posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        posterImageView.sd_setImage(with: url)
        genreLabel.text = model.genres.first?.name
        titleLabel.text = model.name
        ratingLabel.text = "\(model.rating)/5 "
    }

}
