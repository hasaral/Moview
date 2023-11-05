//
//  MovieDetailViewModel.swift
//  Moview
//
//  Created by Hasan Saral on 5.11.2023.
//

import Foundation

protocol MovieDetailViewModelInterface {
    func viewDidload(imdb: String)
    func viewWillAppear()
}

class MovieDetailViewModel: MovieDetailViewModelInterface {
    
    private weak var view: MovieDetailPreviewViewInterface?
    private let dataManager: MovieManagerInterface
    
    init(view: MovieDetailPreviewViewInterface, manager:MovieManagerInterface = MovieManager.shared ) {
        self.view = view
        self.dataManager = manager
    }
    
    func fetchDetailData(imdb: String) {
        LoadingView.startLoading()
        self.dataManager.fetchDetailData(imdb: imdb) { [weak self] res in
            print(res)
            LoadingView.stopLoading()
            self?.view?.showView(path: self?.dataManager.movieDetailData.poster ?? "", name: self?.dataManager.movieDetailData.title ?? "", detail: self?.dataManager.movieDetailData.plot ?? "")
        }
    }
    
    
    func viewDidload(imdb: String) {
        fetchDetailData(imdb: imdb)
    }
    
    func viewWillAppear() {
        
    }
    
    
}
