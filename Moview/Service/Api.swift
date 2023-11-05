//
//  Api.swift
//  Moview
//
//  Created by Hasan Saral on 5.11.2023.
//

import Foundation 

enum MoviesNetworking {
    case getTable(pages: String, search: String)
    case getCollection(pages: String, search: String)
    case getimdbIDDetail(imdbID: String)
}

extension MoviesNetworking: TargetType {
 
    var baseURL: String {
        switch self {
        case .getTable:
            return "http://www.omdbapi.com/?apikey="
        case .getCollection:
            return "http://www.omdbapi.com/?apikey="
        case .getimdbIDDetail:
            return "http://www.omdbapi.com/?apikey="
        }
    }
    
    var search: String {
        switch self {
        case .getTable(_, let search):
            return "9e24fc5c&s=\(search)"
        case .getCollection(_, let search):
            return "9e24fc5c&s=\(search)"
        case .getimdbIDDetail(let imdb):
            return "9e24fc5c&i=\(imdb)"
        }
    }
    
    var path: String {
        switch self {
        case .getTable(let page, _):
            return "&page=\(page)"
        case .getCollection(let page, _):
            return "&page=\(page)"
        case .getimdbIDDetail:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getTable:
            return .get
        case .getCollection:
            return .get
        case .getimdbIDDetail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getTable:
            return .requestMovie
        case .getCollection:
            return .requestMovie
        case .getimdbIDDetail:
            return .requestMovie
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Task {
    case requestMovie
}

protocol TargetType {
 
    var baseURL: String { get }
 
    var search: String { get }

    var path: String { get }
 
    var method: HTTPMethod { get }
 
    var task: Task { get }
 
    var headers: [String: String]? { get }
}
