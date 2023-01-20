//
//  GameListViewController.swift
//  RawGameApp
//
//  Created by kamilcal on 18.01.2023.
//

import UIKit

class GameListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    private let viewModel = HomeViewModel()
    
    private var page = 1


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getGameData(with: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }

    
    
    private func getGameData(with page: Int) {
        viewModel.fetchGamesData(with: page) { [weak self] (result) in
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVc = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "a") as? GameDetailViewController
        detailVc?.id = viewModel.gameResult[indexPath.row].id
        self.navigationController?.pushViewController(detailVc!, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        
        if offsetY > contentHeight - height {
            page += 1
            getGameData(with: page)
        }
    }

}
