//
//  UIViewController + Ext.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//


import UIKit
import SafariServices

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showAlert(title: String?, message: String?, completion: @escaping ((UIAlertAction) -> ()) ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction( UIAlertAction(title: "Delete", style: .destructive, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
}
extension UIViewController {
    func presentSafariVC(with url: URL) {
        let SFSafariViewController = SFSafariViewController(url: url)
        present(SFSafariViewController, animated: true)
    }
}
