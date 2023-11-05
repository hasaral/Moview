//
//  MovieDetailPreviewView.swift
//  Moview
//
//  Created by Hasan Saral on 5.11.2023.
//

import Foundation
import UIKit

protocol MovieDetailPreviewViewInterface: AnyObject {
    func showView(path: String, name: String, detail: String)
}

final class MovieDetailPreviewView: UIView {
    
    private lazy var headLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.backgroundColor = .clear
        return label
    }()
    
    var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle("Geri", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let detailImageView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = UIImage(named: "movieic")
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        theImageView.contentMode = .scaleAspectFit
        return theImageView
    }()
    
    lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "movie"
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.backgroundColor = .clear
        return label
    }()
    
    let textView:UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.font = UIFont.systemFont(ofSize: 15)
        view.backgroundColor = .white
        view.isEditable = false
        return view
    }()
    
    private lazy var topView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
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
        
        [topView, detailImageView,movieNameLabel,textView].forEach { addSubview($0) }
        
        topView.addSubview(headLabel)
        topView.addSubview(backButton)
        topView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: topPadding , left: 0, bottom: 0, right: 0))
        topView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addConstraint(heightMulti(item: topView, toItem: self, multiplier: 0.05908695652))
        addConstraint(widthMulti(item: topView, toItem: self, multiplier: 1))
        
        backButton.anchor(top: topView.topAnchor, leading: topView.leadingAnchor, bottom: topView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: .init(width:60, height:0))
        [backButton.centerYAnchor.constraint(equalTo:  topView.centerYAnchor),backButton.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier:1)].forEach { $0?.isActive = true }
        
        headLabel.anchor(top: topView.topAnchor, leading: nil, bottom: topView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width:0, height: 0))
        
        [headLabel.centerXAnchor.constraint(equalTo:  topView.centerXAnchor),
         headLabel.centerYAnchor.constraint(equalTo:  topView.centerYAnchor),
         headLabel.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier:0.4830917874)].forEach { $0?.isActive = true }
        
        detailImageView.anchor(top: topView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0 , left: 20, bottom: 0, right: 20))
        detailImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addConstraint(heightMulti(item: detailImageView, toItem: self, multiplier: 0.2))
        
        movieNameLabel.anchor(top: detailImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10), size: .init(width:0, height: 110))
        
        textView.anchor(top: movieNameLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 20, bottom: 10, right: 20), size: .init(width:0, height: 0))
      
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
