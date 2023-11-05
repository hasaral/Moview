//
//  DetailModel.swift
//  Moview
//
//  Created by Hasan Saral on 5.11.2023.
//

import Foundation

struct DetailMovieModel: Codable {
    let title, year, rated, released: String?
    let runtime, genre, director, writer: String?
    let actors, plot, language, country: String?
    let awards: String?
    let poster: String?
    let ratings: [Rating]?
    let metascore, imdbRating, imdbVotes, imdbID: String?
    let type, totalSeasons, response: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case totalSeasons = "totalSeasons"
        case response = "Response"
    }
}
 
struct Rating: Codable {
    let source, value: String?

    enum CodingKeys: String, CodingKey {
        case source
        case value = "Value"
    }
}

 
