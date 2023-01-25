//
//  EmptyCollectionViewCell.swift
//  RawGameApp
//
//  Created by kamilcal on 20.01.2023.
//

import UIKit

class EmptyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var emptyLabel: UILabel!{
        didSet{
            emptyLabel.text = NSLocalizedString("EmptyCollection", comment: "There are no games saved at this time.")
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
