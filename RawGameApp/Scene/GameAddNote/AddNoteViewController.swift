//
//  AddNoteViewController.swift
//  RawGameApp
//
//  Created by kamilcal on 22.01.2023.
//

import UIKit



class AddNoteViewController: UIViewController {

    @IBOutlet var saveButton: UIButton!{
        didSet{
            saveButton.setTitle(NSLocalizedString("SaveButton", comment: "Save"), for: .normal)
            saveButton.setTitle(NSLocalizedString("SaveButton", comment: "Save"), for: .disabled)
        }
    }
    @IBOutlet var titleLabel: UITextField!{
        didSet{
            titleLabel.placeholder = NSLocalizedString("NoteTitle", comment: "Note Title")
        }
    }
    
    @IBOutlet var detailLabel: UITextView!
    
    var viewModel = AddNoteViewModel()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    
    func configureView(){
        titleLabel.becomeFirstResponder()
        detailLabel.text = viewModel.getNoteTitle()
        titleLabel.text = viewModel.getNoteText()
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if self.titleLabel.text == "" || self.detailLabel.text == ""{
            showAlertActions()
            return
        }
        if let note = viewModel.note{
            note.text = self.titleLabel.text
            note.title = self.detailLabel.text
            viewModel.delegateNoteList?.noteUpdated(note: note)
        }
        else {
            viewModel.delegateNoteList?.noteAdded(title: self.titleLabel.text!, text: self.detailLabel.text)
        }
        dismiss(animated: true)
    }

    func showAlertActions() {
        let alert = UIAlertController(title: NSLocalizedString("alertTitle", comment: "Warning!"),
                                      message: NSLocalizedString("alertMessage", comment: "Note title or text cannot be blank"),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("okAction", comment: "Ok"), style: .default, handler: { _ in
        }))
        self.present(alert, animated: true)
    }
    
    
    

}
