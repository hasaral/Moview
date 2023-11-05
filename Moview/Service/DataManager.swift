//
//  DataManager.swift
//  Moview
//
//  Created by Hasan Saral on 4.11.2023.
//

import Foundation
import UIKit

protocol MovieManagerInterface {
    var tableData : SearchMovieModel { get }
    var collectionData : SearchMovieModel { get }
    var movieDetailData : DetailMovieModel { get }
    var tableViewCount: String { get }
    var collectionCount: String { get }
    func fetchTableData(pages: String, search: String, completion: @escaping (Result<SearchMovieModel, APError>) -> Void)
    func fetchCollectionData(pages: String, completion: @escaping (Result<SearchMovieModel, APError>) -> Void)
    func fetchDetailData(imdb: String, completion: @escaping (Result<DetailMovieModel, APError>) -> Void)
}

final class MovieManager: MovieManagerInterface {
    
    static let shared = MovieManager()
    
    var tableData: SearchMovieModel = SearchMovieModel(Search: [], totalResults: "", Response: "")
    var collectionData: SearchMovieModel = SearchMovieModel(Search: [], totalResults: "", Response: "")
    var movieDetailData: DetailMovieModel = DetailMovieModel(title: "", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", ratings: [], metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", totalSeasons: "", response: "")
    
    var tableViewCount: String = "1"
    var tableViewNowCount: Int =  1
    
    var collectionCount: String = "1"
    var collectionNowCount: Int = 1
    
    func fetchTableData(pages: String, search: String, completion: @escaping (Result<SearchMovieModel, APError>) -> Void) {
        getTableData(pages: pages, search: search) { (res) in
            switch res {
            case .success(_):
                DispatchQueue.main.async {
                    completion(.success(self.tableData))
                }
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func fetchCollectionData(pages: String, completion: @escaping (Result<SearchMovieModel, APError>) -> Void) {
        getCollectionData(pages: pages) { (res) in
            DispatchQueue.main.async {
                completion(.success(self.collectionData))
            }
        }
    }
    
    func fetchDetailData(imdb: String, completion: @escaping (Result<DetailMovieModel, APError>) -> Void) {
        getDetailData(imdb: imdb) { res in
            DispatchQueue.main.async {
                completion(.success(self.movieDetailData))
            }
        }
    }
    
    private func getTableData(pages: String, search: String,completed: @escaping (Result<SearchMovieModel, APError>) -> Void) {
        NetworkManager.shared.getTableData(pages: pages, search: search, completed: { result in
            switch result {
            case .success(let res):
                if self.tableViewNowCount == 1 {
                    self.tableData = res
                } else {
                    self.tableData.Search.append(contentsOf: res.Search)
                }
                self.tableViewCount = res.totalResults ?? "1"
                completed(result)
            case .failure(_):
                completed(result)
            }
        })
    }
    
    private func getCollectionData(pages: String,completed: @escaping (SearchMovieModel) -> Void) {
        NetworkManager.shared.getCollectionData(pages: pages, completed: { result in
            if self.collectionNowCount == 1 {
                self.collectionData = result
            } else {
                self.collectionData.Search.append(contentsOf: result.Search)
            }
            self.collectionCount = result.totalResults ?? "1"
            completed(result)
        })
    }
    
    private func getDetailData(imdb: String,completed: @escaping (DetailMovieModel) -> Void) {
        NetworkManager.shared.getDetailData(imdb: imdb, completed: { result in
            self.movieDetailData = result
            completed(result)
        })
    }
    
    func removeData() {
        self.tableData.Search.removeAll()
    }
    
}


