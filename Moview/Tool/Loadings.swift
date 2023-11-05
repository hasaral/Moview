//
//  Loadings.swift
//  Moview
//
//  Created by Hasan Saral on 4.11.2023.
//

import Foundation
import UIKit

open class LoadingView {
    internal static var spinnerView: UIActivityIndicatorView?
    
    public static var style: UIActivityIndicatorView.Style = .white
    public static var backgroundColor: UIColor = UIColor(white: 0, alpha: 0.3)
    
    internal static var touchHandler: (() -> Void)?
    
    public static func startLoading(style: UIActivityIndicatorView.Style = style, backgroundColor: UIColor = backgroundColor, touchHandler: (() -> Void)? = nil) {
        if spinnerView == nil,
            let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            spinnerView = UIActivityIndicatorView(frame: frame)
            spinnerView!.backgroundColor = backgroundColor
            spinnerView!.style = style
            spinnerView?.color = .blue
            window.addSubview(spinnerView!)
            spinnerView!.startAnimating()
        }
        
        if touchHandler != nil {
            self.touchHandler = touchHandler
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(runTouchHandler))
            spinnerView!.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc internal static func runTouchHandler() {
        if touchHandler != nil {
            touchHandler!()
        }
    }
    
    public static func stopLoading() {
 
        DispatchQueue.main.async {
            if let _ = spinnerView {
                spinnerView!.stopAnimating()
                spinnerView!.removeFromSuperview()
                spinnerView = nil
            }
        }
    }
}

