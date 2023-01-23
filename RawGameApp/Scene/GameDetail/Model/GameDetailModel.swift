//
//  GameDetailModel.swift
//  RawGameApp
//
//  Created by kamilcal on 19.01.2023.
//

import Foundation

// MARK: - GameDetailModel
struct GameDetailModel: Codable {
    let id: Int
    let name, gameDetailModelDescription: String
    let backgroundImage: String?
    let added: Int
    let rating: Double
    let ratingTop: Int?
    let released: String?
    let reviewsCount: Int


    enum CodingKeys: String, CodingKey {
        case name, released
        case id
        case gameDetailModelDescription = "description_raw"
        case backgroundImage = "background_image"
        case added
        case rating
        case ratingTop = "rating_top"
        case reviewsCount = "reviews_count"
    }
}


