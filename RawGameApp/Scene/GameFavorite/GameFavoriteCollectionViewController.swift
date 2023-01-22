//
//  GameFavoriteCollectionViewController.swift
//  RawGameApp
//
//  Created by kamilcal on 20.01.2023.
//

import UIKit
import SDWebImage


class GameFavoriteCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var viewModel = FavoriteViewModel()
    var selectedMovieID: Int?
    var gameModel = [GameFavoriteModel]()

    private let sectionInsets = UIEdgeInsets(top: 15.0,
                                             left: 2.0,
                                             bottom: 15.0,
                                             right: 2.0)
    private let itemsPerRow: CGFloat = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.register(UINib(nibName: "EmptyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "emptyCell")
        loadGameFavouritesData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    private func loadGameFavouritesData() {
        viewModel.loadFavouriteData { [weak self] (result) in
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
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if viewModel.gameFavouritesResult.count == 0 {
            return 1
        }
        return viewModel.gameFavouritesResult.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if viewModel.gameFavouritesResult.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath) as! EmptyCollectionViewCell
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GameFavoriteCollectionViewCell
            cell.configure(with: viewModel.gameFavouritesResult[indexPath.row])
            return cell
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "a") as? GameDetailViewController
        detailVc?.id = viewModel.gameFavouritesResult[indexPath.row].id
        self.navigationController?.pushViewController(detailVc!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
                if viewModel.gameFavouritesResult.count == 0 {
                    return CGSize(width: collectionView.bounds.width, height: 55)
                }
        
        let paddingSpace = sectionInsets.left * (itemsPerRow )
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    

    
  
    
}

    

