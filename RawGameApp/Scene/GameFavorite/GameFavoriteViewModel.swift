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
    private lazy var dataManager: CoreDataManager = { return CoreDataManager() }()
    weak var delegate: FavoriteListViewModelDelegate?

    init(gameProvider: CoreDataManager = CoreDataManager()) {
        self.dataManager = dataManager
    }
    func loadFavoriteData(completion: @escaping (Result<[GameFavoriteModel], NetworkErrorHandling>) -> Void) {
        self.dataManager.getFavoritesData { result in
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
        self.dataManager.deleteFavoriteGame(id)
        self.delegate?.favoriteGamesChanged()

//            switch result {
//            case .success(_):
//                completion(.success)
//            case .failure(let error):
//                print("\(error)")
//                completion(.failure(error as? NetworkErrorHandling ?? .apiError))
//            }
        

    }
}
