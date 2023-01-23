//
//  AddNoteViewModel.swift
//  RawGameApp
//
//  Created by kamilcal on 23.01.2023.
//

import Foundation


protocol AddNoteViewModelProtocol {
    func getNoteTitle() -> String?
    func getNoteText() -> String?
    
}

class AddNoteViewModel {
    var note: Note?

    
    weak var delegateNoteList: NoteListViewModelDelegate?

    func getNoteTitle() -> String? {
        note?.title
    }
    func getNoteText() -> String? {
        note?.text
    }
}
