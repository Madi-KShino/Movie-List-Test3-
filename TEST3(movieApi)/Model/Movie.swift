//
//  Movie.swift
//  TEST3(movieApi)
//
//  Created by Madison Kaori Shino on 6/28/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation

//FIRST LEVEL
struct TopLevelMovieDictionary: Decodable {
    
    let results: [MovieDictionary]
    
}

//SECOND LEVEL
struct MovieDictionary: Decodable {
    
    let title: String
    let rating: Double
    let summary: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case rating = "vote_average"
        case summary = "overview"
        case date = "release_date"
    }
}

