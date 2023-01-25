//
//  GameListViewController.swift
//  RawGameApp
//
//  Created by kamilcal on 18.01.2023.
//

import UIKit

class SearchListViewController: UIViewController, UISearchResultsUpdating {

    @IBOutlet var tableView: UITableView!
    var timer: Timer?

    private var page = 1
    private var searchText: String?

    private let viewModel = SearchListViewModel()
    var gameResult = [ResultGame]()
    
    //MARK: - Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        setupSearchController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
// MARK: - setupUI
    
    private func setupUI(){
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = NSLocalizedString("SearchList", comment: "Search")
    }

// MARK: - Searchbar

    private func setupSearchController(){
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.tintColor = .white
        search.searchBar.placeholder = NSLocalizedString("SearchPlaceholder", comment: "Enter game name to search")
        search.searchBar.barTintColor = .white
        navigationItem.searchController = search
        search.searchBar.setNewcolor(color: .white)
    
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
//            if text.count > 1 {
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
                    self?.showActivityIndicator()
                    self?.viewModel.fetchGamesData(with: self!.page, searchText: text) { result in
                        switch result {
                        case .success(_):
                            DispatchQueue.main.async {
                                self?.removeActivityIndicator()
                                self?.tableView.reloadData()
                            }
                        case .failure(let error):
                            self?.removeActivityIndicator()
                            print("Error on: \(error.localizedDescription)")
                        }
                    }
                })
//            }
//        tableView.reloadData()
        }
    }


//MARK: - Delegate - DataSource Methods


extension SearchListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gameResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchListTableViewCell
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
//            getGameData(with: page, searchText: nil)
        }
    }

}

