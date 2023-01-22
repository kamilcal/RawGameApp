//
//  HomeListViewController.swift
//  RawGameApp
//
//  Created by kamilcal on 21.01.2023.
//

import UIKit




class HomeListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    private let dispatchGroup = DispatchGroup()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.shadowImage = UIImage()
        setNeedsStatusBarAppearanceUpdate()
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentDetailModal(notif:)), name: NSNotification.Name(rawValue: "presentDetail"), object: nil)
    }
    
    @objc func presentDetailModal(notif: NSNotification) {
        if let userInfo = notif.userInfo {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailVC = storyboard
                .instantiateViewController(withIdentifier: "a") as? GameDetailViewController {
                detailVC.id = userInfo["id"] as! Int
                print("home:\(detailVC.id)")
                navigationController?.pushViewController(detailVC, animated: true)
            }
//            detailVc?.id = viewModel.gameResult[indexPath.row].id

        }
    }
}
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
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var titleText: String?
        if section == 0 {
            titleText = "Popular"
        } else if section == 1 {
            titleText = "Metacritic"
        } else if section == 2 {
            titleText = "Upcoming"
        }
        
        var view: UIView
        view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        
        
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 35))
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.text = titleText
        label.textColor = .white
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



