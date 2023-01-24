//
//  APIHome.swift
//  RawGameApp
//
//  Created by kamilcal on 24.01.2023.
//

import Foundation

enum MovieCategory {
    case popular
    case metacritic
}

enum HomeEndpoint: String {
    case popular
    case metacritic
    
    
    
    var path: String {
        switch self {
        case .popular:
            return APIConstant.popularURL
        case .metacritic:
            return APIConstant.metacriticURL
            
        }
    }
}
