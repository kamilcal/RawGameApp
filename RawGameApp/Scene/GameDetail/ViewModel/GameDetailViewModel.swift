//
//  GameDetailViewModel.swift
//  RawGameApp
//
//  Created by kamilcal on 19.01.2023.
//

import UIKit


class DetailViewModel {
    private let apiService: APIClients
    var gameDetailResult: GameDetailModel?
//    var dataManager: CoreDataManager = { return CoreDataManager() }()
    var isFavourited: Bool = false
    
    private var game: GameDetailModel?
    init(apiService: APIClients = APIClients()) {
        self.apiService = apiService
    }
    func fetchGamesData(id: Int, completion: @escaping (Result<GameDetailModel, NetworkErrorHandling>) -> Void) {
        self.apiService.fetchGamesDetail(id: id) { result in
            switch result {
            case .success(let data):
                self.gameDetailResult = data
                print("\(String(describing: self.gameDetailResult?.name))")
                completion(.success(data))
            case .failure(let error):
                print("Error processing json data: \(error)")
                completion(.failure(error as? NetworkErrorHandling ?? .apiError))
            }
        }
    }
    
    func addToFavorite(id: Int?) -> Bool {
        let id = id
        let name = gameDetailResult?.name ?? ""
        let releaseDate = gameDetailResult?.released ?? ""
        let description = gameDetailResult?.gameDetailModelDescription ?? ""
        let image = gameDetailResult?.backgroundImage ?? ""
        let added = gameDetailResult?.added ?? 0
        let reviewsCount = gameDetailResult?.reviewsCount ?? 0
        CoreDataManager.shared.addFavoriteGame(gameData: GameFavoriteModel(id: id,
                                                                 name: name,
                                                                 gameDetailModelDescription: description,
                                                                 backgroundImage: image,
                                                                 added: added,
                                                                 released: releaseDate,
                                                                 reviewsCount: reviewsCount)) {
        }
        return true
    }
    
    func removeToGame(id: Int?) -> Bool {
        CoreDataManager.shared.deleteFavoriteGame(id ?? 0)
        return true
    }
    
}
