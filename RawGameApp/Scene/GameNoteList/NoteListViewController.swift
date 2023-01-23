//
//  NoteListViewController.swift
//  RawGameApp
//
//  Created by kamilcal on 22.01.2023.
//

import UIKit

class NoteListViewController: UIViewController {

    @IBOutlet var noteTableView: UITableView!{
        didSet {
            noteTableView.delegate = self
            noteTableView.dataSource = self
        }
    }
    
    private var viewModel = GameNoteListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getNotes()


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getNotes()

    }
    

    
    @IBAction func addNoteButton(_ sender: Any) {
        performSegue(withIdentifier: "noteToAddNote", sender: nil)
//        TODO: SEGUE'yi değşiştir
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "noteToAddNote" {
            let destination = segue.destination as! AddNoteViewController
            destination.viewModel.delegateNoteList = self
            guard let sender else {return}
            destination.viewModel.note = sender as? Note
        
        }
    }

    
}

extension NoteListViewController: NoteListViewModelDelegate {
    
    func notesChanged() {
        noteTableView.reloadData()
    }
    
    
    func noteAdded(title: String, text: String) {
        viewModel.appendNote(title: title, text: text)
    }
    func noteUpdated(note: Note) {
        viewModel.updateNote(note: note)
    }

}

extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameNoteListCell") as? GameNoteListTableViewCell,
              let note = viewModel.getNote(at: indexPath.row) else {return UITableViewCell()}
        
        cell.configure(note: note)
        // TODO: force unwrap i aç
        return cell
    }
}
