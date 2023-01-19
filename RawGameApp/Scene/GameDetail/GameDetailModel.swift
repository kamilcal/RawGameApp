//
//  GameDetailModel.swift
//  RawGameApp
//
//  Created by kamilcal on 19.01.2023.
//

import Foundation

// MARK: - GameDetailModel
struct GameDetailModel: Codable {
    let idGame: Int
    let name, gameDetailModelDescription: String
    let backgroundImage: String?
    let added: Int
    let rating: Double
    let ratingTop: Int?
    let released: String?
    let reviewsCount: Int


    enum CodingKeys: String, CodingKey {
        case name, released
        case idGame = "id"
        case gameDetailModelDescription = "description_raw"
        case backgroundImage = "background_image"
        case added
        case rating
        case ratingTop = "rating_top"
        case reviewsCount = "reviews_count"
    }
}



//// MARK: - GameDetailModel
//struct GameDetailModel: Decodable {
//    let idGame: Int
//    let slug, name, nameOriginal, gameDetailModelDescription: String
//    let metacritic: Int
//    let released: String
//    let backgroundImage, backgroundImageAdditional: String
//    let rating: Double
//    let ratingTop: Int
////    let ratings: [Rating]
//    let added: Int
//    let reviewsTextCount: Int
//    let ratingsCount, suggestionsCount: Int
//    let parentsCount, additionsCount, gameSeriesCount: Int
//    let reviewsCount: Int
//    let descriptionRaw: String
//
//    enum CodingKeys: String, CodingKey {
//        case idGame = "id"
//        case slug, name
//        case nameOriginal = "name_original"
//        case gameDetailModelDescription = "description"
//        case metacritic
//        case released
//        case backgroundImage = "background_image"
//        case backgroundImageAdditional = "background_image_additional"
//        case rating
//        case ratingTop = "rating_top"
////        case ratings, added
//        case added
//        case reviewsTextCount = "reviews_text_count"
//        case ratingsCount = "ratings_count"
//        case suggestionsCount = "suggestions_count"
//        case parentsCount = "parents_count"
//        case additionsCount = "additions_count"
//        case gameSeriesCount = "game_series_count"
//        case reviewsCount = "reviews_count"
//        case descriptionRaw = "description_raw"
//    }
//}
////// MARK: - Rating
////struct Rating: Codable {
////    let id: Int
////    let title: Title
////    let count: Int
////    let percent: Double
////}
////
////enum Title: String, Codable {
////    case exceptional = "exceptional"
////    case meh = "meh"
////    case recommended = "recommended"
////    case skip = "skip"
////}
