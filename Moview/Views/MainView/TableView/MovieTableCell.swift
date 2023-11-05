//
//  MovieTableCell.swift
//  Moview
//
//  Created by Hasan Saral on 4.11.2023.
//

import UIKit

protocol MovieTableCellViewInterface: AnyObject {
    func setImageView(path: String)
    func setTitle(title: String)
}

class MovieTableViewCell: UITableViewCell, MovieTableCellViewInterface {
 
    var presenter: MovieTableCellPresenter! {
        didSet {
            presenter.load()
        }
    }
    
    var topView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var backView : UIView = {
        let view = UIView()
        DispatchQueue.main.async {
            view.applyShadowWithCornerRadius(color: .lightGray, opacity: 0.4, radius: 16, edge: .All, shadowSpace: 9)
        }
        view.backgroundColor = .white
        return view
    }()
    
    var spaceLeft : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var spaceImage : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var spaceLabelTop : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var cellImage : UIImageView = {
        let theImageView = UIImageView()
        theImageView.backgroundColor = .white
        theImageView.layer.cornerRadius = 15
        theImageView.layer.masksToBounds = true
        theImageView.contentMode = .scaleAspectFill
        return theImageView
    }()
 
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.backgroundColor = .clear
        label.numberOfLines = 2
        return label
    }()
 
    var imageLink = ""
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    func setTitle(title: String) {
        nameLabel.text = title
    }
    
    func autoLayout() {
        
        [topView, spaceLeft, backView, cellImage, nameLabel, spaceImage, spaceLabelTop].forEach { contentView.addSubview($0) }
        
        topView.anchor(top: contentView.topAnchor, leading: nil, bottom:nil, trailing: nil, padding: .init(top: 0 , left: 0, bottom: 0, right: 0))
        topView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        self.contentView.addConstraint(heightMulti(item: topView, toItem: contentView, multiplier:0.1176470588))
        self.contentView.addConstraint(widthMulti(item: topView, toItem: contentView, multiplier: 1))
        
        spaceLeft.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom:nil, trailing: nil, padding: .init(top: 0 , left: 0, bottom: 0, right: 0))
        self.contentView.addConstraint(heightMulti(item: spaceLeft, toItem: contentView, multiplier:1))
        self.contentView.addConstraint(widthMulti(item: spaceLeft, toItem: contentView, multiplier: 0.0845410628))
        
        cellImage.anchor(top: contentView.topAnchor, leading: spaceLeft.trailingAnchor, bottom:nil, trailing: nil, padding: .init(top: 0 , left: 0, bottom: 0, right: 0))
        self.contentView.addConstraint(heightMulti(item: cellImage, toItem: contentView, multiplier:0.8125))
        self.contentView.addConstraint(widthMulti(item: cellImage, toItem: contentView, multiplier: 0.2898550725))
        
        backView.anchor(top: topView.bottomAnchor, leading: nil, bottom:nil, trailing: nil, padding: .init(top: 0 , left: 0, bottom: 0, right: 0))
        backView.centerXAnchor.constraint(equalTo:  contentView.centerXAnchor).isActive = true
        self.contentView.addConstraint(heightMulti(item: backView, toItem: contentView, multiplier:0.7894736842))
        self.contentView.addConstraint(widthMulti(item: backView, toItem: contentView, multiplier: 0.9275362319))
        
        spaceImage.anchor(top: contentView.topAnchor, leading: cellImage.trailingAnchor, bottom:nil, trailing: nil, padding: .init(top: 0 , left: 0, bottom: 0, right: 0))
        self.contentView.addConstraint(heightMulti(item: spaceImage, toItem: contentView, multiplier:1))
        self.contentView.addConstraint(widthMulti(item: spaceImage, toItem: contentView, multiplier: 0.02415458937))
        
        spaceLabelTop.anchor(top: backView.topAnchor, leading: spaceImage.trailingAnchor, bottom:nil, trailing: contentView.trailingAnchor, padding: .init(top: 0 , left: 0, bottom: 0, right: 0))
        self.contentView.addConstraint(heightMulti(item: spaceLabelTop, toItem: contentView, multiplier:0.125))

        nameLabel.anchor(top: spaceLabelTop.bottomAnchor, leading: spaceImage.trailingAnchor, bottom:nil, trailing: nil, padding: .init(top: 0 , left: 0, bottom: 0, right: 0))
        self.contentView.addConstraint(heightMulti(item: nameLabel, toItem: contentView, multiplier:0.3125))
        self.contentView.addConstraint(widthMulti(item: nameLabel, toItem: contentView, multiplier: 0.4830917874))
 
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
  
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

