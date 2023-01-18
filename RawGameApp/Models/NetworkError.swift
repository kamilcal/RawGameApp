//
//  NetworkError.swift
//  RawGameApp
//
//  Created by kamilcal on 19.01.2023.
//

import Foundation

enum NetworkErrorHandling: Error, CustomNSError {
    case networkError
    case apiError
    case decodingError
    var localizedDescription: String {
        switch self {
        case .apiError: return "apı error"
        case .networkError: return "network error"
        case .decodingError: return "decoding error"
        }
    }
}
