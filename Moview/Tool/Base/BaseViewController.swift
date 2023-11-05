//
//  BaseViewController.swift
//  Moview
//
//  Created by Hasan Saral on 4.11.2023.
//

import UIKit

class BaseViewController:UIViewController {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
}

public extension NSObject {

    var className: String {
        return type(of: self).className
    }

    static var className: String {
        return stringFromClass(aClass: self)
    }

}

public func stringFromClass(aClass: AnyClass) -> String {
    return NSStringFromClass(aClass).components(separatedBy: ".").last!
}
