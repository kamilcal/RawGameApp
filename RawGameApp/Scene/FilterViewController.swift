//
//  FilterView.swift
//  RawGameApp
//
//  Created by kamilcal on 24.01.2023.
//

import UIKit
import PanModal

class FilterController: UIViewController {
    
    
    @IBOutlet weak var filterTable: UITableView!
    
    
    var selectionCallback: ((GameCategory)->())?
    let viewModel = FilterViewModel()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterTable.register(UINib(nibName: "\(TitleTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(TitleTableViewCell.self)")

    }
    
}

extension FilterController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TitleTableViewCell.self)", for: indexPath) as! TitleTableViewCell
        cell.configure(title: viewModel.items[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) { [weak self] in
            self?.selectionCallback?(self?.viewModel.items[indexPath.row].type ?? .popular)
            print("\(self?.viewModel.items[indexPath.row].type)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

extension FilterController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(200)
    }
    
    var cornerRadius: CGFloat {
        20
    }

}
