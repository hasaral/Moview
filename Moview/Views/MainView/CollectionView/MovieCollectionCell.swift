//
//  MovieCollectionCell.swift
//  Moview
//
//  Created by Hasan Saral on 4.11.2023.
//

import UIKit
 
protocol MovieCollectionCellViewInterface: AnyObject {
    func setImageView(path: String)
}

class MovieCollectionCell: UICollectionViewCell, MovieCollectionCellViewInterface {
    lazy var cellImage : UIImageView = {
        let theImageView = UIImageView()
        theImageView.backgroundColor = .clear
        theImageView.layer.cornerRadius = 15
        theImageView.layer.masksToBounds = true
        theImageView.contentMode = .scaleAspectFill
        return theImageView
    }()
    
    var presenter: MovieCollectionCellPresenter! {
        didSet {
            presenter.load()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImageView(path: String) {
       load(fromURLString: path, completed: { image in
           self.cellImage.image = image
        })
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
 
    func autoLayout() {
        
        [cellImage].forEach { contentView.addSubview($0) }

        cellImage.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom:nil, trailing: contentView.trailingAnchor, padding: .init(top: 5 , left: 5, bottom: 5, right: 5))
        self.contentView.addConstraint(heightMulti(item: cellImage, toItem: contentView, multiplier:1))
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
