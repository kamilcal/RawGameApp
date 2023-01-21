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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        getData()

    }
    
    func setupUI() {
        self.popularCollectionView.delegate = self
        self.popularCollectionView.dataSource = self
        self.popularCollectionView.backgroundColor = .clear

    }
    private func getData() {
        viewModel.fetchGamesGroupedData { (result) in
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
extension PopularTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.popular.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCollectionCell", for: indexPath) as! PopularCollectionViewCell
        cell.configure(with: viewModel.popular[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PopularCollectionViewCell {
            print(cell.id)
            guard let id = cell.id else { return }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "kamil"), object: nil, userInfo: ["id": id])
        }
    }
   
}
