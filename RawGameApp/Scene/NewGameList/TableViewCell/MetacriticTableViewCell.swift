//
//  MetacriticTableViewCell.swift
//  RawGameApp
//
//  Created by kamilcal on 21.01.2023.
//

import UIKit

class MetacriticTableViewCell: UITableViewCell {
    
    
    private let viewModel = HomeListViewModel()
    
    @IBOutlet var metacriticCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        getData()
    }
    
    private func setupUI(){
        metacriticCollectionView.delegate = self
        metacriticCollectionView.dataSource = self
    }
    
    private func getData() {
        viewModel.fetchGamesGroupedData(url: APIConstant.metacriticURL) { (result) in
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
            self.metacriticCollectionView.reloadData()
            
        }
        
    }
}

extension MetacriticTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.gameResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "metacriticCollectionCell", for: indexPath) as! MetacriticCollectionViewCell
        cell.configure(with: viewModel.gameResult[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is MetacriticCollectionViewCell {
            let id = viewModel.gameResult[indexPath.row].id
            print("cell:\(id)")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "presentDetail"), object: nil, userInfo: ["id": id])
        }
    }
}
