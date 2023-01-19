//
//  GameModel.swift
//  RawGameApp
//
//  Created by kamilcal on 19.01.2023.
//

import Foundation

struct GameModel: Decodable {
    let results: [ResultGame]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - GameModel
struct ResultGame: Decodable {
    let idGame: Int
    let slug, name, released: String
    let tba: Bool
    let backgroundImage: String?
    let rating: Double
    let ratingTop: Int
//    let ratings: [Rating]
    let ratingsCount, reviewsTextCount, added: Int
    let metacritic: Int?
    let playtime, suggestionsCount: Int
    let updated: String
    let reviewsCount: Int
    let genres: [Genre]
    let tags: [Genre]

    enum CodingKeys: String, CodingKey {
        case idGame = "id"
        case slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
//        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case reviewsCount = "reviews_count"
        case genres, tags
    }
}



// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int?
    let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}


// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    let id: Int
    let name, slug: String
    let yearStart: Int?
    let gamesCount: Int
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}



// MARK: - Requirements
struct Requirements: Codable {
    let minimum: String
    let recommended: String?
}





