//
//  MovieTableCellPresenter.swift
//  Moview
//
//  Created by Hasan Saral on 4.11.2023.
//

protocol MovieTableCellPresenterInterface {
    func load()
}

final class MovieTableCellPresenter {
    private weak var view: MovieTableCellViewInterface?
    private let arguments: MovieTableCellArguments
    
    init(view: MovieTableCellViewInterface, arguments: MovieTableCellArguments) {
        self.view = view
        self.arguments = arguments
    }
}

extension MovieTableCellPresenter: MovieTableCellPresenterInterface {
    func load() {
        view?.setImageView(path: arguments.image)
        view?.setTitle(title: arguments.name)
    }
}
