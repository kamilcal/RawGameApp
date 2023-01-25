//
//  HomeListViewController.swift
//  RawGameApp
//
//  Created by kamilcal on 21.01.2023.
//

import UIKit

class HomeListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    let viewModel = HomeListViewModel()

//MARK: - Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentDetailModal(notif:)), name: NSNotification.Name(rawValue: "presentDetail"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
//MARK: - SetupUI

    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.shadowImage = UIImage()
        setNeedsStatusBarAppearanceUpdate()
    }
    

//MARK: - NotificationCenter

    @objc func presentDetailModal(notif: NSNotification) {
        if let userInfo = notif.userInfo {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailVC = storyboard
                .instantiateViewController(withIdentifier: "a") as? GameDetailViewController {
                detailVC.id = userInfo["id"] as? Int
                navigationController?.pushViewController(detailVC, animated: true)
            }

        }
    }
}

//MARK: - Delegate - DataSource Methods

extension HomeListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
     return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as? PopularTableViewCell {
             return cell
            }
        } else if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "metactiticCell", for: indexPath) as? MetacriticTableViewCell {
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell", for: indexPath) as? UpcomingTableViewCell {
                return cell
            }
        }
        return UITableViewCell()
    }
    
//MARK: - SetupUI

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var titleText: String?
        if section == 0 {
            titleText = NSLocalizedString("Popular", comment: "Popular")
        } else if section == 1 {
            titleText = NSLocalizedString("Metacritic", comment: "Metacritic")
        } else if section == 2 {
            titleText = NSLocalizedString("Upcoming", comment: "Upcoming")
        }
        
        var view: UIView
        view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        
        
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 35))
        label.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        label.text = titleText
        label.textColor = UIColor(named: "greenColor")
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 230
        } else if indexPath.section == 1{
            return 260
        } else {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 230
        } else if indexPath.section == 1{
            return 260
        } else {
            return 200
        }
    }
}



