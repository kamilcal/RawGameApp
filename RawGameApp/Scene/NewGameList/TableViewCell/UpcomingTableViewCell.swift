//
//  UpcomingTableViewCell.swift
//  RawGameApp
//
//  Created by kamilcal on 21.01.2023.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    @IBOutlet var upcomingCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI(){
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
    }
    

}
extension UpcomingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCollectionCell", for: indexPath) as! UpcomingCollectionViewCell
        return cell
    }
}
