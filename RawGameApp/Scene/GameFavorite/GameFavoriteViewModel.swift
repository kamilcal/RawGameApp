//
//  GameFavoriteViewModel.swift
//  RawGameApp
//
//  Created by kamilcal on 20.01.2023.
//

import Foundation

class FavoriteViewModel {
    var gameFavouritesResult = [GameFavoriteModel]()
    private lazy var dataManager: CoreDataManager = { return CoreDataManager() }()
    init(gameProvider: CoreDataManager = CoreDataManager()) {
        self.dataManager = dataManager
    }
    func loadFavouriteData(completion: @escaping (Result<[GameFavoriteModel], NetworkErrorHandling>) -> Void) {
        self.dataManager.getFavouritesData { result in
            switch result {
            case .success(let data):
                self.gameFavouritesResult = data
                completion(.success(data))
            case .failure(let error):
                print("\(error)")
                completion(.failure(error as? NetworkErrorHandling ?? .apiError))
            }
        }
    }
    func deleteFavoriteData(_ id: Int) {
        self.dataManager.deleteFavouriteGame(id)
//            switch result {
//            case .success(_):
//                completion(.success)
//            case .failure(let error):
//                print("\(error)")
//                completion(.failure(error as? NetworkErrorHandling ?? .apiError))
//            }
        

    }
}
