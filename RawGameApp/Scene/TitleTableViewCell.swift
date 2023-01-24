//
//  TitleTableViewCell.swift
//  RawGameApp
//
//  Created by kamilcal on 24.01.2023.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
}
