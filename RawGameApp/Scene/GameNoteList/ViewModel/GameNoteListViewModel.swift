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
    func notesChanged()
    func noteAdded(title: String, text: String)
    func noteUpdated(note: Note)
}

class GameNoteListViewModel: NoteListViewModelProtocol{
    
    weak var delegate: NoteListViewModelDelegate?

    var notes: [Note]?
//    private lazy var dataManager: CoreDataManager = { return CoreDataManager() }()

    func getNote(at index: Int) -> Note? {
       notes?[index]
    }
    
    func appendNote(title: String, text: String) {
        guard let note = CoreDataManager.shared.saveNote(title: title, text: text) else {return}
        notes?.append(note)
        self.delegate?.notesChanged()
    }
    func updateNote(note: Note) {
        CoreDataManager.shared.updateNote(note: note)
        self.delegate?.notesChanged()
    }
    
    func getNotes() {
        self.notes = CoreDataManager.shared.getNotes()
        self.delegate?.notesChanged()
    }
    
    
}
