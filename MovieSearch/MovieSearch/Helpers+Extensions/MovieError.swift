//
//  MovieError.swift
//  MovieSearch
//
//  Created by Bryan Workman on 3/29/22.
//

import Foundation

enum MovieError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    case unableToDecodeImage
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The Server failed to reach the necessary URL."
        case .thrownError(let error):
            return "There was an error: \(error.localizedDescription)"
        case .noData:
            return "There was no data found"
        case .unableToDecode:
            return "There was an error when trying to load the data"
        case .unableToDecodeImage:
            return "There was an error when trying to load the image"
        }
    }
}
