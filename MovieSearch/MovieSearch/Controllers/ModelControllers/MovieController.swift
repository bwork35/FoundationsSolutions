//
//  MovieController.swift
//  MovieSearch
//
//  Created by Bryan Workman on 3/29/22.
//

import Foundation
import UIKit.UIImage

class MovieController {
    
    //MARK: - String Constants
    fileprivate static let baseURL = URL(string: "https://api.themoviedb.org")
    fileprivate static let threeComponent = "3"
    fileprivate static let searchComponent = "search"
    fileprivate static let movieComponent = "movie"
    fileprivate static let apiKeyKey = "api_key" 
    fileprivate static let apiKeyValue = "YOUR_API_KEY_HERE"
    fileprivate static let queryKey = "query"
    fileprivate static let imageBaseURL = URL(string: "http://image.tmdb.org/t/p/w500")
    
    //MARK: - Fetch Functions
    static func fetchMoviesWith(searchTerm: String, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let threeURL = baseURL.appendingPathComponent(threeComponent)
        let searchURL = threeURL.appendingPathComponent(searchComponent)
        let movieURL = searchURL.appendingPathComponent(movieComponent)
        
        var components = URLComponents(url: movieURL, resolvingAgainstBaseURL: true)
        
        let apiQueryItem = URLQueryItem(name: apiKeyKey, value: apiKeyValue)
        let movieSearchQuery = URLQueryItem(name: queryKey, value: searchTerm)
        
        components?.queryItems = [apiQueryItem, movieSearchQuery]
        
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
               return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelDict = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                let movieItemsArray = topLevelDict.results
                
               return completion(.success(movieItemsArray))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImageFor(movie: Movie, completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        guard let imageURL = imageBaseURL, let posterPath = movie.image else {return completion(.failure(.invalidURL)) }
        let finalImageURL = imageURL.appendingPathComponent(posterPath)

        URLSession.shared.dataTask(with: finalImageURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecodeImage))}
            
            completion(.success(image))
        }.resume()
    }
    
} //End of class
