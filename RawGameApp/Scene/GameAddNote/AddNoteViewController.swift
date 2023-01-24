//
//  AddNoteViewController.swift
//  RawGameApp
//
//  Created by kamilcal on 22.01.2023.
//

import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet var titleLabel: UITextField!
    @IBOutlet var detailLabel: UITextView!
    
    var viewModel = AddNoteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
        configureView()
    }
    
    func setupUI(){
        if detailLabel.text == ""{
            detailLabel.text = "Enter your note here..."
            detailLabel.textColor = UIColor.secondaryLabel
        }
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
    func configureView(){
        titleLabel.becomeFirstResponder()
        detailLabel.text = viewModel.getNoteTitle()
        titleLabel.text = viewModel.getNoteText()
    }
    func showAlertActions() {
        let alert = UIAlertController(title: "asmkdlas",
                                      message: "dmlalşsdlas", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
        }))
        self.present(alert, animated: true)
    }
    
    
    

}
