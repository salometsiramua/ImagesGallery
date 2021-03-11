//
//  UIViewController+Extensions.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import UIKit

extension UIViewController {
    func showAlert(with error: Error) {
        stopIndicatingActivity()
        let message = error.localizedDescription
        let alert = UIAlertController(title: "Error occured", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Acitivity Indicator
    struct Holder {
        static var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    }
    
    var indicator: UIActivityIndicatorView {
        get {
            return Holder.activityIndicatorView
        }
        
        set (newValue){
            Holder.activityIndicatorView = newValue
        }
        
    }
    
    func startIndicatingActivity() {
        DispatchQueue.main.async {
            self.view.addSubview(self.indicator)
            self.indicator.pin(to: self.view, directions: [.centerX, .centerY])
            self.indicator.startAnimating()
        }
    }

    func stopIndicatingActivity() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
        }
    }
}
