//
//  GameDetailViewModel.swift
//  RawGameApp
//
//  Created by kamilcal on 19.01.2023.
//

import Foundation

class DetailViewModel {
    private let apiService: APIClients
    var gameDetailResult: GameDetailModel?
    var isFavourited: Bool = false
    init(apiService: APIClients = APIClients()) {
        self.apiService = apiService
    }
    func fetchGamesData(idGame: Int, completion: @escaping (Result<GameDetailModel, NetworkErrorHandling>) -> Void) {
        self.apiService.fetchGamesDetail(idGame: idGame) { result in
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
