//
//  PopularTableViewCell.swift
//  RawGameApp
//
//  Created by kamilcal on 21.01.2023.
//

import UIKit

class PopularTableViewCell: UITableViewCell {
    

    private let viewModel = HomeListViewModel()
    @IBOutlet var popularCollectionView: UICollectionView!
    
//MARK: - Lifecycle Functions

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        config()
    }
    
//MARK: - SetupUI
    
    func setupUI() {
        self.popularCollectionView.delegate = self
        self.popularCollectionView.dataSource = self
        self.popularCollectionView.backgroundColor = .clear
        
    }
    func config() {
        getData()
        viewModel.successCallback = { [weak self] in
            self?.popularCollectionView.reloadData()
        }
        
    }
//MARK: - FetchData

    private func getData() {
        viewModel.fetchGamesGroupedData(url: APIConstant.popularURL) { (result) in
            switch result {
            case .success(_):
                self.updateTableUI()
            case .failure(let error):
                print("Error on: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateTableUI() {
        DispatchQueue.main.async {
            self.popularCollectionView.reloadData()
            
        }
    }
}

//MARK: - Delegate - DataSource Methods

extension PopularTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.gameResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCollectionCell", for: indexPath) as! PopularCollectionViewCell
        cell.configure(with: viewModel.gameResult[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PopularCollectionViewCell {
            let id = viewModel.gameResult[indexPath.row].id
            print("cell:\(id)")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "presentDetail"), object: nil, userInfo: ["id": id])
        }
    }
   
}
