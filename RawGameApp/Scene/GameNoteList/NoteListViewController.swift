//
//  NoteListViewController.swift
//  RawGameApp
//
//  Created by kamilcal on 22.01.2023.
//

import UIKit

class NoteListViewController: UIViewController {
    
    @IBOutlet var noteTableView: UITableView!

    
    
    private var viewModel = GameNoteListViewModel()
    
//MARK: - Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
//MARK: - setupUI
    func setupUI(){
        noteTableView.delegate = self
        noteTableView.dataSource = self
        viewModel.delegate = self
        viewModel.getNotes()
        navigationItem.title = NSLocalizedString("Notes", comment: "Notes")
    }
    
//MARK: - Action

 
    @IBAction func addNoteButton(_ sender: Any) {
        performSegue(withIdentifier: "noteToAddNote", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "noteToAddNote" {
            let destination = segue.destination as! AddNoteViewController
            destination.viewModel.delegateAddNote = self
            guard let sender else {return}
            destination.viewModel.note = sender as? Note
            
        }
    }
    
    
}


//MARK: - Delegate - DataSource Methods

extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameNoteListCell") as? GameNoteListTableViewCell,
              let note = viewModel.getNote(at: indexPath.row) else {return UITableViewCell()}
        cell.configure(note: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "noteToAddNote", sender: viewModel.getNote(at: indexPath.row))
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: NSLocalizedString("alertTitle", comment: "Warning!"),
                                                message: NSLocalizedString("alertTitleDetail", comment: "Are you sure you want to delete?"),
                                                preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: NSLocalizedString("alertOkDetail", comment: "Yes"),
                                          style: .default) { _ in
            if editingStyle == .delete {
                self.viewModel.deleteNote(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancelAction", comment: "Give up"),
                                         style: .cancel)
        
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: false)
    }
    
}


extension NoteListViewController: NoteListViewModelDelegate {
    
    
    func changed() {
        noteTableView.reloadData()
    }
    func updated(note: Note) {
        viewModel.updateNote(note: note)
    }
    
    func added(title: String, text: String) {
        viewModel.appendNote(title: title, text: text)
    }
 
}
