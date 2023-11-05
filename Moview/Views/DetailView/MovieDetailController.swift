//
//  MovieDetailController.swift
//  Moview
//
//  Created by Hasan Saral on 5.11.2023.
//

import Foundation
import UIKit
 
class MovieDetailController: BaseViewController, MovieDetailPreviewViewInterface {
 
    var viewPreview = MovieDetailPreviewView()
    
    override func loadView() {
        view = viewPreview
    }
    
    var imdbID: String
    private lazy var viewModel: MovieDetailViewModel = {
        return MovieDetailViewModel(view: self)
    }()

    init(imdbID: String) {
        self.imdbID = imdbID
        super.init(nibName: nil, bundle: nil)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidload(imdb: imdbID)
        viewPreview.backButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    func showView(path: String, name: String, detail: String) {
        load(fromURLString: path, completed: { image in
            self.viewPreview.detailImageView.image = image
         })
        
        viewPreview.movieNameLabel.text = name
        viewPreview.textView.text = detail
    }
    
    @objc func buttonAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
 
    func load(fromURLString urlString: String, completed: @escaping(UIImage?) -> Void)  {
        NetworkManager.shared.downloadImage(fromURLString: urlString) { uiImage in
            guard let uiImage = uiImage else {
                return
            }
            DispatchQueue.main.async {
                completed(uiImage)
            }
        }
    }
}
