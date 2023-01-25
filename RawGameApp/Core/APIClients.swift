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
        
        var url = url
        
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
        
        guard var urlComponents = URLComponents(string: Url.sourceURL) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: APIKey.key, value: APIValue.key),
            URLQueryItem(name: APIKey.pageLimit, value: APIValue.pageLimit),
            URLQueryItem(name: APIKey.page, value: String(pageNumber))
        ]
        if let searchText = searchText {
            let searchQueryItem = URLQueryItem(name: APIKey.search, value: searchText)
            urlComponents.queryItems?.append(searchQueryItem)
        }
        guard let url = urlComponents.url else {
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
        guard var urlcomponents = URLComponents(string: Url.sourceURL) else { return }
        urlcomponents.queryItems = [URLQueryItem(name: APIKey.key, value: APIValue.key)]
        
        let urlWithPath = urlcomponents.url?.appendingPathComponent(String(id))
        
        guard let url = urlWithPath else {
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
