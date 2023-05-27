//
//  UIViewController+SafeAreaInsets.swift
//  GamesExplorer
//
//  Created by AhmedFitoh on 5/29/23.
//

import UIKit

extension UIViewController {
    var safeAreaInsets: UIEdgeInsets {
        return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
    }
}
