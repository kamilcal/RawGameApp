//
//  GameListViewController.swift
//  RawGameApp
//
//  Created by kamilcal on 18.01.2023.
//

import UIKit

class GameListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    private let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getGameData()
    }
    
    private func getGameData() {
        viewModel.fetchGamesData { [weak self] (result) in
            switch result {
            case .success(let data):
                print(data)
                self?.updateTableUI()
            case .failure(let error):
                print("Error on: \(error.localizedDescription)")
            }
        }
    }
        private func updateTableUI() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            
        }
    }
    

}

extension GameListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gameResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameListTableViewCell
            cell.configure(with: viewModel.gameResult[indexPath.row])
        return cell
    }
}
