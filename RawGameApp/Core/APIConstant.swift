//
//  APITypes.swift
//  RawGameApp
//
//  Created by kamilcal on 21.01.2023.
//

import Foundation


struct APIConstant {
    static let baseURL = "https://api.rawg.io/api"
    static let games = "games?"
    static var apıKey =  "41673d9d79af427a9faab5f57864ed50"
    
    static let metacriticURL = "\(baseURL)/\(games)key=\(apıKey)&dates=2000-01-01,2023-01-15&ordering=-metacritic&page_size=50"
    static let popularURL =
    "\(baseURL)/\(games)key=\(apıKey)&dates=2022-01-01,2022-12-31&ordering=-added"
    static let upcomingURL = "\(baseURL)/\(games)key=\(apıKey)&dates=2023-01-25,2025-12-31&ordering=-added&page_size=50"
    
}
    
enum Url {
    static let sourceURL = "https://api.rawg.io/api/games?"
}

enum APIKey {
    static let key = "key"
    static let pageLimit = "page_size"
    static let page = "page"
    static let search = "search"
}

enum APIValue {
    static let key = "41673d9d79af427a9faab5f57864ed50"
    static let pageLimit = "10"
}



    
