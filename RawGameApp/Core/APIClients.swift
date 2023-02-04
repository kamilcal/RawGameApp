//
//  APIClients.swift
//  RawGameApp
//
//  Created by kamilcal on 19.01.2023.
//

import Foundation

class APIClients {

    private var dataTask: URLSessionTask?
    
            
// MARK: - HOMEVİEW DATA

    func fetchGroupeData(url: String, completion: @escaping (Result<GameModel, Error>) -> Void) {
        
        let url = url
        
        guard let url = URL(string: url) else {
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
    
    
// MARK: - SEARCH DATA
    
    func fetchSearchData(pageNumber: Int,searchText: String?, completion: @escaping (Result<GameModel, Error>) -> Void) {
        
        var urlString = "\(APIConstant.baseURL)/games?key=\(APIConstant.apıKey)&page_size=20"
        if let searchText = searchText{
            urlString = urlString + "&search=\(searchText)"
        }
        
        guard let url = URL(string: urlString) else {
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
    
// MARK: - DETAİL DATA
    
    func fetchGamesDetail(id: Int, completion: @escaping (Result<GameDetailModel, Error>) -> Void) {
        
        let urlString = "\(APIConstant.baseURL)/games/\(id)?key=\(APIConstant.apıKey)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("fetchGamesDetail DataTask Error: \(error.localizedDescription)")
            }
            guard let response = response as? HTTPURLResponse else {
                print("fetchGamesDetail: Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            guard let data = data else {
                print("fetchGamesDetail: Empty Data")
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(GameDetailModel.self, from: data)
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
