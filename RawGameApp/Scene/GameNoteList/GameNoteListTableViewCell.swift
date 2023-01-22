//
//  GameNoteListTableViewCell.swift
//  RawGameApp
//
//  Created by kamilcal on 22.01.2023.
//

import UIKit

class GameNoteListTableViewCell: UITableViewCell {

    
    @IBOutlet var noteTitleLabel: UILabel!
    @IBOutlet var noteCommentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
