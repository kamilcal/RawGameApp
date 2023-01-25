//
//  GameFavoriteViewModel.swift
//  RawGameApp
//
//  Created by kamilcal on 20.01.2023.
//

import Foundation

protocol FavoritesListViewModelProtocol {
    var delegate: FavoriteListViewModelDelegate? {get set}
    func deleteFavoriteData(_ id: Int)

}

protocol FavoriteListViewModelDelegate: AnyObject {
    func favoriteGamesChanged()
}

class FavoriteViewModel {
    var gameFavoritesResult = [GameFavoriteModel]()
    weak var delegate: FavoriteListViewModelDelegate?


    func loadFavoriteData(completion: @escaping (Result<[GameFavoriteModel], NetworkErrorHandling>) -> Void) {
        CoreDataManager.shared.getFavoritesData { result in
            switch result {
            case .success(let data):
                self.gameFavoritesResult = data
                completion(.success(data))
            case .failure(let error):
                print("\(error)")
                completion(.failure(error as? NetworkErrorHandling ?? .apiError))
            }
        }
    }
    func deleteFavoriteData(_ id: Int) {
        CoreDataManager.shared.deleteFavoriteGame(id)
        delegate?.favoriteGamesChanged()

    
    }
}
