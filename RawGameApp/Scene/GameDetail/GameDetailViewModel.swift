//
//  GameDetailViewModel.swift
//  RawGameApp
//
//  Created by kamilcal on 19.01.2023.
//

import UIKit

protocol DetailViewModelProtocol {
    func addToFavorites() -> Bool
}


class DetailViewModel {
    private let apiService: APIClients
    var gameDetailResult: GameDetailModel?
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

}
