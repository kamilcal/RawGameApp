//
//  HomeListViewModel.swift
//  RawGameApp
//
//  Created by kamilcal on 21.01.2023.
//

import Foundation



class HomeListViewModel {
    private let apiService: APIClients
//    var popular = [ResultGame]()
    var gameResult = [ResultGame]()
    init(apiService: APIClients = APIClients()) {
        self.apiService = apiService
    }
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
//    func fetchGamesData(with page: Int,searchText: String?, completion: @escaping (Result<[ResultGame], NetworkErrorHandling>) -> Void) {
//        self.apiService.fetchGamesData(pageNumber: page, searchText: searchText) { result in
//            switch result {
//            case .success(let data):
//                self.gameResult = data.results
//                completion(.success(data.results))
//            case .failure(let error):
//                print("Error processinng json data: \(error)")
//                completion(.failure(error as? NetworkErrorHandling ?? .apiError))
//            }
//        }
//    }
}
