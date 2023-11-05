//
//  MoviesPreviewView.swift
//  Moview
//
//  Created by Hasan Saral on 4.11.2023.
//

import Foundation
import UIKit

protocol MovieViewInterface: AnyObject {    
    func prepareCollectionView()
    func prepareTableView()
    func tableViewReloadData()
    func collectionReloadData()
    func prepareSearchBar()
    func addKeybordType()
}

struct MovieCollectionCellArguments {
     let type: StatisticType
     let image: String
}

extension MovieCollectionCellArguments {
    enum StatisticType: Int {
        case one = 0
        var image: String {
            switch self {
            case .one:
                return "one"
            }
        }
    }
}

struct MovieTableCellArguments {
     let type: StatisticType
     let name: String
     let image: String
 }

extension MovieTableCellArguments {
    enum StatisticType: Int {
        case one = 0
        var image: String {
            switch self {
            case .one:
                return "one"
            }
        }
    }
}

final class MoviesPreviewView: UIView {
 
    private lazy var headLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Filmler"
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var topView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        return searchBar
    }()
    
    
    lazy var tableData: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        return table
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return collectionView
    }()
    
    var topPadding: CGFloat = 0
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
        setLayout()
        backgroundColor = .white
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setLayout() {
 
        if let window = UIApplication.shared.windows.first {
            topPadding = window.safeAreaInsets.top
            _ = window.safeAreaInsets.bottom
            
            if topPadding < 25 {
                topPadding = 20
            }
        }
        
        [topView,searchBar,tableData,collectionView].forEach { addSubview($0) }
        
        topView.addSubview(headLabel)
        topView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: topPadding , left: 0, bottom: 0, right: 0))
        topView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addConstraint(heightMulti(item: topView, toItem: self, multiplier: 0.05908695652))
        addConstraint(widthMulti(item: topView, toItem: self, multiplier: 1))
        
        headLabel.anchor(top: topView.topAnchor, leading: nil, bottom: topView.bottomAnchor, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width:0, height: 0))
        
        [headLabel.centerXAnchor.constraint(equalTo:  topView.centerXAnchor),
         headLabel.centerYAnchor.constraint(equalTo:  topView.centerYAnchor),
         headLabel.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier:0.4830917874)].forEach { $0?.isActive = true }
        
        searchBar.anchor(top: topView.bottomAnchor, leading: nil, bottom: tableData.topAnchor, trailing: nil, padding: .init(top: 0 , left: 0, bottom: 0, right: 0))
        searchBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addConstraint(widthMulti(item: searchBar, toItem: self, multiplier: 1))
        
        tableData.anchor(top: searchBar.bottomAnchor, leading: nil, bottom: collectionView.topAnchor, trailing: nil, padding: .init(top: 20 , left: 0, bottom: 0, right: 0))
        tableData.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //self.view.addConstraint(heightMulti(item: tableData, toItem: view, multiplier: 0.08967391304))
        addConstraint(widthMulti(item: tableData, toItem: self, multiplier: 1))
        
        collectionView.anchor(top: tableData.bottomAnchor, leading: nil, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0 , left: 0, bottom: 0, right: 0))
        //collectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addConstraint(heightMulti(item: collectionView, toItem: self, multiplier: 0.19967391304))
        addConstraint(widthMulti(item: collectionView, toItem: self, multiplier: 1))
   
    }
    
    func heightMulti(item:UIView,toItem:UIView,multiplier: CGFloat) -> NSLayoutConstraint {
        let heightConstraint = NSLayoutConstraint(item: item,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: toItem,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  multiplier: multiplier, constant: 0)
        return heightConstraint
    }
    
    func widthMulti(item:UIView,toItem:UIView,multiplier: CGFloat) -> NSLayoutConstraint {
        let widthConstraint = NSLayoutConstraint(item: item,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: toItem,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 multiplier: multiplier, constant: 0)
        return widthConstraint
    }
}


