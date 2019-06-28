//
//  MovieController.swift
//  TEST3(movieApi)
//
//  Created by Madison Kaori Shino on 6/28/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class MovieController {
    
    //PROPERTIES
    static let sharedInstance = MovieController()
    
    //BASE URL
    //https://api.themoviedb.org/3/search/movie?api_key={api_key}&query=Jack+Reacher
    static let baseURL = URL(string: "https://api.themoviedb.org")
    
    //RETRIEVE MOVIES FROM SEASRCH
    static func fetchMovie(searchEntered: String, completion: @escaping ([Movie]?) -> Void) {
        
        //CREATE FULL URL
        guard var url = baseURL else { completion([]); return }
        url.appendPathComponent("3")
        url.appendPathComponent("search")
        url.appendPathComponent("movie")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let apiKeyComponent = URLQueryItem(name: "api_key", value: "2edd94ba9756a40627eea1eddc4d0007")
        let searchQueryComponent = URLQueryItem(name: "query", value: searchEntered)
        components?.queryItems = [apiKeyComponent, searchQueryComponent]
        guard let completeURL = components?.url else { completion([]); return }
        
        //RETRIEVE DATA WITH FULL URL
        URLSession.shared.dataTask(with: completeURL) { (data, _, error) in
            if let error = error {
                print("Oops! Something went wrong with the search: \(error.localizedDescription)")
                completion([])
                return
            }
            
            if let data = data {
                
                //DECODE DATA
                do {
                    let topLevelDict = try JSONDecoder().decode(TopLevelMovieDictionary.self, from: data)
                    completion(topLevelDict.results)
                } catch {
                    print("Oops! Something went wrong while decoding the data: \(error.localizedDescription)")
                    completion([])
                    return
                }
            }
        }.resume()
    }
    
    //RETRIEVE MOVIE IMAGES
    static func fetchMovieImages(forMovie: Movie, completion: @escaping (((UIImage)?) -> Void)) {
        
        //IMAGE URL
        guard var baseURL = URL(string: "https://image.tmdb.org/t/p/w500") else { completion(nil); return }
        guard let imageExtension = forMovie.image else { return }
        baseURL.appendPathComponent(imageExtension)
        
        //RETRIEVE IMAGES
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                print("Oh No! Image Search Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Oh No! Data wasn't fetched correctly")
                completion(nil)
                return
            }
            
            let itemImage = UIImage(data: data)
            completion(itemImage)
            
        }.resume()
    }
}
