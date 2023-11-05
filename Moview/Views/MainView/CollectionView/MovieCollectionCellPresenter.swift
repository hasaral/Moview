//
//  MovieCollectionCellPresenter.swift
//  Moview
//
//  Created by Hasan Saral on 4.11.2023.
//


protocol MovieCollectionCellPresenterInterface {
    func load()
}

final class MovieCollectionCellPresenter {
    private weak var view: MovieCollectionCellViewInterface?
    private let arguments: MovieCollectionCellArguments
    
    init(view: MovieCollectionCellViewInterface, arguments: MovieCollectionCellArguments) {
        self.view = view
        self.arguments = arguments
    }
}

extension MovieCollectionCellPresenter: MovieCollectionCellPresenterInterface {
    func load() {
        view?.setImageView(path: arguments.image)
    }
     
}
