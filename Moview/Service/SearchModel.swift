//
//  SearchModel.swift
//  Moview
//
//  Created by Hasan Saral on 4.11.2023.
//

import Foundation

struct SearchMovieModel: Codable {
    var Search: [Search]
    let totalResults, Response: String?

    enum CodingKeys: String, CodingKey {
        case Search
        case totalResults
        case Response
    }
}
 
struct Search: Codable {
    let Title, Year, imdbID: String?
    let Types: String?
    let Poster: String?

    enum CodingKeys: String, CodingKey {
        case Title
        case Year
        case imdbID
        case Types = "Type"
        case Poster
    }
}

 
