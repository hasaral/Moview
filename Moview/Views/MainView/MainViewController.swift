//
//  ViewController.swift
//  Moview
//
//  Created by Hasan Saral on 4.11.2023.
//

import UIKit
 
class MainViewController: BaseViewController {
    var viewPreview = MoviesPreviewView()
    
    override func loadView() {
        view = viewPreview
    }
     
    private lazy var viewModel: MoviesPreviewViewModel = {
        return MoviesPreviewViewModel(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
 
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedMovie(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieManager.shared.tableData.Search.isEmpty ?  0 : MovieManager.shared.tableData.Search.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return .init()
        }

        let item = viewModel.cellForTableItem(at: indexPath)
        let cellPresenter = MovieTableCellPresenter(view: cell, arguments: item.arguments)
        cell.presenter = cellPresenter
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if indexPath.row == (MovieManager.shared.tableData.Search.count)-4 && !self.viewModel.isLoading && MovieManager.shared.tableData.Search.count != Int(MovieManager.shared.tableViewCount) {
                MovieManager.shared.tableViewNowCount += 1
                self.viewModel.fetchTableData(pages: MovieManager.shared.tableViewNowCount.description, search: self.viewModel.searchActive ? self.viewModel.searchText : "Star")
            }
        }
    }
}

 ////////////////CollectionView
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieManager.shared.collectionData.Search.isEmpty ?  0 : MovieManager.shared.collectionData.Search.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as? MovieCollectionCell else {
            return .init()
        }

        let item = viewModel.cellForItem(at: indexPath)
        let cellPresenter = MovieCollectionCellPresenter(view: cell, arguments: item.arguments)
        cell.presenter = cellPresenter
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if indexPath.row == (MovieManager.shared.collectionData.Search.count)-4 && !self.viewModel.isLoadingCollection && MovieManager.shared.collectionData.Search.count != Int(MovieManager.shared.collectionCount) {
                MovieManager.shared.collectionNowCount += 1
                self.viewModel.fetchCollectionData(pages: MovieManager.shared.collectionNowCount.description)
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
        
    
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width / 3, height: view.frame.height / 6)
    }
}

////////////SearchBar

extension MainViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //viewModel.searchActive = true
        viewPreview.searchBar.showsCancelButton = true
        viewModel.keyboardType()
    }

//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        viewModel.searchActive = true
//    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        textFieldCloseAction()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchActive = false
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            MovieManager.shared.removeData()
            viewModel.searchActive = true
            viewModel.searchText = searchText
            MovieManager.shared.tableViewNowCount = 1
            self.viewModel.fetchTableData(pages: MovieManager.shared.tableViewNowCount.description, search: searchText)
        }
        
    }
    
    func textFieldCloseAction() {
        if viewModel.searchActive {
            MovieManager.shared.tableViewNowCount = 1
            viewModel.searchActive = false
            MovieManager.shared.removeData()
            viewPreview.searchBar.text = nil
            viewPreview.searchBar.resignFirstResponder()
            //viewPreview.searchBar.showsCancelButton = false
            
            self.viewModel.fetchTableData(pages: MovieManager.shared.tableViewNowCount.description, search: "Star")
        }
 
        view.endEditing(true)
    }
     
}

extension MainViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        viewModel.presentationControllerDidDismiss()
    }
}

extension MainViewController: MovieViewInterface {
    func addKeybordType() {
        addDoneButtonOnKeyboard()
    }
 
    func prepareTableView() {
        viewPreview.tableData.delegate = self
        viewPreview.tableData.dataSource = self
        viewPreview.tableData.reloadData()
    }
    
    func tableViewReloadData() {
        UIHelper.performUpdate {
            self.viewPreview.tableData.reloadData()
        }
    }
    
    func collectionReloadData() {
        viewPreview.collectionView.reloadData()
    }
 
    func prepareCollectionView() {
        viewPreview.collectionView.delegate = self
        viewPreview.collectionView.dataSource = self
        viewPreview.collectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "MovieCollectionCell")
        viewPreview.collectionView.reloadData()
    }
    
    func prepareSearchBar() {
        viewPreview.searchBar.delegate = self
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Kapat", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        viewPreview.searchBar.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        view.endEditing(true)
    }

}
