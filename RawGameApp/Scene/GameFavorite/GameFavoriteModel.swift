//
//  GameFavoriteModel.swift
//  RawGameApp
//
//  Created by kamilcal on 20.01.2023.
//

import Foundation

// MARK: - GameDetailModel
struct GameFavoriteModel: Codable {
    let id: Int?
    let name, gameDetailModelDescription: String?
    let backgroundImage: String?
    let added: Int?
    let released: String?
    let reviewsCount: Int?


    enum CodingKeys: String, CodingKey {
        case name, released
        case id
        case gameDetailModelDescription = "description_raw"
        case backgroundImage = "background_image"
        case added
        case reviewsCount = "reviews_count"
    }
}
