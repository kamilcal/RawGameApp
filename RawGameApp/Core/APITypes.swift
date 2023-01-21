//
//  APITypes.swift
//  RawGameApp
//
//  Created by kamilcal on 21.01.2023.
//

import Foundation

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
    static let key = "9f30d73fb34543318f8d2d6aea8fb41d"
    static let pageLimit = "10"
}

struct APIConstant {
    static let baseURL = "https://api.rawg.io/api"
    static let games = "games"
    static var apıKey =  "41673d9d79af427a9faab5f57864ed50"
    
    static let metacriticURL = "\(baseURL)/\(games)?key=\(apıKey)&dates=2000-01-01,2023-01-15&ordering=-metacritic&page_size=50"
    static let popularURL =
//    "\(BASE_URL)/games?key=\(API_KEY)&dates=2022-01-01,2022-12-31&ordering=-added"
        "\(baseURL)/\(games)?key=\(apıKey)&dates=2022-01-01,2022-12-31&ordering=-added"
    static let upcomingURL = "\(baseURL)/\(games)?key=\(apıKey)&dates=2023-01-15,2025-12-31&ordering=-added&page_size=50"
    


    }
