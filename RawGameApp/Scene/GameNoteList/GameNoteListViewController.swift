//
//  GameNoteListViewController.swift
//  RawGameApp
//
//  Created by kamilcal on 22.01.2023.
//

import UIKit

class GameNoteListViewController: UIViewController {

    @IBOutlet var noteTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addNoteButton(_ sender: Any) {
        performSegue(withIdentifier: "noteToAddNote", sender: nil)
    }

    
}

extension GameNoteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameNoteListCell", for: indexPath)
        return cell
    }
}
