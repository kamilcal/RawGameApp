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
}

protocol NoteListViewModelDelegate: AnyObject {
    func notesChanged()
    func noteAdded(title: String, text: String)
    func noteUpdated(note: Note)
}

class GameNoteListViewModel{
    
    weak var delegate: NoteListViewModelDelegate?

    var notes: [Note]?
    private lazy var dataManager: CoreDataManager = { return CoreDataManager() }()

    func appendNote(title: String, text: String) {
        guard let note = dataManager.saveNote(title: title, text: text) else {return}
        notes?.append(note)
        self.delegate?.notesChanged()
    }
    func updateNote(note: Note) {
        dataManager.updateNote(note: note)
        self.delegate?.notesChanged()
    }
    
    func getNotes() {
        self.notes = dataManager.getNotes()
        self.delegate?.notesChanged()
    }
    
    
}
