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
    


    func configure(note: Note){
        noteTitleLabel.text = note.title
        noteCommentLabel.text = note.text
    }
    

}
