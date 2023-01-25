//
//  GameNoteListViewModel.swift
//  RawGameApp
//
//  Created by kamilcal on 22.01.2023.
//

import Foundation

protocol NoteListViewModelProtocol {
    var delegate: NoteListViewModelDelegate? {get set}
    func getNotes()
    func appendNote(title: String, text: String)
    func updateNote(note: Note)
    func getNote(at index: Int) -> Note?

}

protocol NoteListViewModelDelegate: AnyObject {
    func changed()
    func added(title: String, text: String)
    func updated(note: Note)
}

class GameNoteListViewModel: NoteListViewModelProtocol{
    
    weak var delegate: NoteListViewModelDelegate?

    var notes: [Note]?

    func getNote(at index: Int) -> Note? {
       notes?[index]
    }
    func getNotes() {
        self.notes = CoreDataManager.shared.getNotes()
        self.delegate?.changed()
    }
    func appendNote(title: String, text: String) {
        guard let note = CoreDataManager.shared.saveNote(title: title, text: text) else {return}
        notes?.append(note)
        self.delegate?.changed()
    }
    func updateNote(note: Note) {
        CoreDataManager.shared.updateNote(note: note)
        self.delegate?.changed()
    }
    
    func deleteNote(at index: Int) {
        guard let note = self.getNote(at: index) else {return}
        CoreDataManager.shared.deleteNote(note: note)
        notes?.remove(at: index)
    }
    

    
    
}
