//
//  AddNoteViewModel.swift
//  RawGameApp
//
//  Created by kamilcal on 23.01.2023.
//

import Foundation

class AddNoteViewModel {
    var note: Note?

    
    weak var delegateAddNote: NoteListViewModelDelegate?

    func getTitle() -> String? {
        note?.title
    }
    func getText() -> String? {
        note?.text
    }
}
