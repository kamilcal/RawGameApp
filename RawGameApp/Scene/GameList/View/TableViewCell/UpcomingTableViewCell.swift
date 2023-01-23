//
//  UpcomingTableViewCell.swift
//  RawGameApp
//
//  Created by kamilcal on 21.01.2023.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    private let viewModel = HomeListViewModel()

    @IBOutlet var upcomingCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        getData()
    }
    func setupUI(){
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
    }
    private func getData() {
        viewModel.fetchGamesGroupedData(url: APIConstant.upcomingURL) { (result) in
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
            self.upcomingCollectionView.reloadData()
            
        }
        
    }
    

}
extension UpcomingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.gameResult.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCollectionCell", for: indexPath) as! UpcomingCollectionViewCell
        cell.configure(with: viewModel.gameResult[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is UpcomingCollectionViewCell {
            let id = viewModel.gameResult[indexPath.row].id
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "presentDetail"), object: nil, userInfo: ["id": id])
        }
    }
}
