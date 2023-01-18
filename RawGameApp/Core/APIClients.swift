//
//  APIClients.swift
//  RawGameApp
//
//  Created by kamilcal on 19.01.2023.
//

import Foundation

class APIClients {
    private let apiKey = "41673d9d79af427a9faab5f57864ed50"
    private let baseURL = "https://api.rawg.io/api"
    private var dataTask: URLSessionTask?
    func fetchGamesData(completion: @escaping (Result<GameModel, Error>) -> Void) {
        let placesURL = "\(baseURL)/games?key=\(apiKey)"
        guard let url = URL(string: placesURL) else {
            return
        }
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("fetchGamesData DataTask Error: \(error.localizedDescription)")
            }
            guard let response = response as? HTTPURLResponse else {
                print("fetchGamesData: Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            guard let data = data else {
                print("fetchGamesData: Empty Data")
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(GameModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}
