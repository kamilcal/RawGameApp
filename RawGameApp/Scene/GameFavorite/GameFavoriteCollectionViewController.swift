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
    //    var dataManager: CoreDataManager = { return CoreDataManager() }()
    
    
    private let sectionInsets = UIEdgeInsets(top: 15.0,
                                             left: 2.0,
                                             bottom: 15.0,
                                             right: 2.0)
    private let itemsPerRow: CGFloat = 3
    
    //MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.register(UINib(nibName: "EmptyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "emptyCell")
        loadGameFavouritesData()
        favoriteGamesChanged()
    }
    
    
    //MARK: - Load Data
    
    private func loadGameFavouritesData() {
        //        self.showActivityIndicator()
        viewModel.loadFavoriteData { [weak self] (result) in
            switch result {
            case .success(_):
                self?.updateTableUI()
                //                self?.removeActivityIndicator()
            case .failure(let error):
                print("Error on: \(error.localizedDescription)")
                self?.removeActivityIndicator()
            }
        }
    }
    private func updateTableUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
    }
    
    //MARK: - UI
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if viewModel.gameFavoritesResult.count == 0 {
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
    
    
    
    //MARK: - Delegate, DataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if viewModel.gameFavoritesResult.count == 0 {
            return 1
        }
        return viewModel.gameFavoritesResult.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if viewModel.gameFavoritesResult.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath) as! EmptyCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GameFavoriteCollectionViewCell
            let index = viewModel.gameFavoritesResult[indexPath.row]
            cell.configure(with: index)
            
            cell.favoriteBtn = { [unowned self] in
                viewModel.deleteFavoriteData(index.id!)
                collectionView.reloadData()
                //                TODO: force
            }
            
            return cell
        }
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let detailVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "a") as? GameDetailViewController
        detailVc?.id = viewModel.gameFavoritesResult[indexPath.row].id
        self.navigationController?.pushViewController(detailVc!, animated: true)
    }
    
    
}

extension GameFavoriteCollectionViewController: FavoriteListViewModelDelegate {
    func favoriteGamesChanged() {
        //        if viewModel.gameFavoritesResult.count > -1{
        updateTableUI()
        //            self.collectionView.reloadData()
        //        }
    }
    
    
}



