//
//  HomeListViewModel.swift
//  RawGameApp
//
//  Created by kamilcal on 21.01.2023.
//

import Foundation

class HomeListViewModel {

    private let apiService: APIClients
    var gameResult = [ResultGame]()
    init(apiService: APIClients = APIClients()) {
        self.apiService = apiService
    }
    var successCallback: (()->())?

    var game: GameModel?
    

    
    func fetchGamesGroupedData(url: String,completion: @escaping (Result<[ResultGame], NetworkErrorHandling>) -> Void) {
        self.apiService.fetchGroupeData(url: url) { result in
            switch result {
            case .success(let data):
                self.gameResult = data.results
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error as? NetworkErrorHandling ?? .apiError))

            }
        }
    }
    
}
