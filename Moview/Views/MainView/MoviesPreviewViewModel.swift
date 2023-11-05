//
//  MoviesPreviewViewModel.swift
//  Moview
//
//  Created by Hasan Saral on 4.11.2023.
//

import Foundation
import UIKit

protocol MoviesPreviewViewModelInterface {
    //var detailType: DetailListViewController.DetailType { get }
    //var view: HomeViewInterface? { get set }
    
    func viewDidload()
    func viewWillAppear()
    func didSelectItem(at indexPath: IndexPath)
    func selectedMovie(at indexPath: IndexPath)
    func presentationControllerDidDismiss()
    func cellForItem(at indexPath: IndexPath) -> (arguments: MovieCollectionCellArguments, backgroundColor: String)
}

class MoviesPreviewViewModel {
    
    private weak var view: MovieViewInterface?
    private var shouldNeedToCallPulledDownRefreshControl: Bool = false
    private var selectedIndex: Int = 0
    private let dataManager: MovieManagerInterface
    var isLoading = false
    var isLoadingCollection = false
    var searchActive : Bool = false
    var searchText : String = ""
 
    init(view: MovieViewInterface, manager:MovieManagerInterface = MovieManager.shared ) {
        self.view = view
        self.dataManager = manager
    }
    
   func fetchTableData(pages: String, search: String) {
 
       LoadingView.startLoading()
       if !self.isLoading {
           self.isLoading = true
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
               self.dataManager.fetchTableData(pages: pages, search: search) { [weak self] res in
                   switch res {
                   case .success(_):
                       self?.view?.tableViewReloadData()
                   case .failure(_):
                       MovieManager.shared.removeData()
                       self?.view?.tableViewReloadData()
                   }
   
                   self?.isLoading = false
               }
           }
       }
    }
    
   func fetchCollectionData(pages: String) {
  
       LoadingView.startLoading()
       if !self.isLoadingCollection {
           self.isLoadingCollection = true
           dataManager.fetchCollectionData(pages: pages) { [weak self] res in
               print(res)
               self?.view?.collectionReloadData()
            
               self?.isLoadingCollection = false
           }
       }
    }
}

extension MoviesPreviewViewModel: MoviesPreviewViewModelInterface {
 
    func viewDidload() {
        view?.prepareCollectionView()
        view?.prepareTableView()
        view?.prepareSearchBar()
        fetchTableData(pages: dataManager.tableViewCount, search: "Star")
        fetchCollectionData(pages: dataManager.collectionCount)
    }
    
    func viewWillAppear() {
        
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let vc = MovieDetailController(imdbID: MovieManager.shared.collectionData.Search[indexPath.row].imdbID ?? "")
        navigate(viewController: vc)
    }
 
    func selectedMovie(at indexPath: IndexPath) {
        let vc = MovieDetailController(imdbID: MovieManager.shared.tableData.Search[indexPath.row].imdbID ?? "")
        navigate(viewController: vc)
    }
    
    func navigate(viewController: UIViewController) {
        if let topVC = UIApplication.getTopViewController() {
            topVC.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func cellForItem(at indexPath: IndexPath) -> (arguments: MovieCollectionCellArguments, backgroundColor: String) {
        var cellType: MovieCollectionCellArguments.StatisticType
        var image: String
        var backgroundColor: String
 
        backgroundColor = "FF9060"
        cellType = .one
        image = dataManager.collectionData.Search[indexPath.row].Poster ?? ""
        
        return (arguments: .init(type: cellType, image: image), backgroundColor: backgroundColor)
    }
    
    func cellForTableItem(at indexPath: IndexPath) -> (arguments: MovieTableCellArguments, backgroundColor: String) {
        var cellType: MovieTableCellArguments.StatisticType
        var name: String
        var image: String
        var backgroundColor: String
        
        name = dataManager.tableData.Search[indexPath.row].Title ?? ""
        image = dataManager.tableData.Search[indexPath.row].Poster ?? ""
        backgroundColor = "00000"
        cellType = .one
        
        return (arguments: .init(type: cellType, name: name, image: image), backgroundColor: backgroundColor)
    }
    
    func presentationControllerDidDismiss() {
        
    }
    
    func keyboardType() {
        view?.addKeybordType()
    }
     
}
