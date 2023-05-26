//
//  UIFont+get.swift
//  GamesExplorer
//
//  Created by AhmedFitoh on 5/26/23.
//

import UIKit

extension UIFont {
    class func get(font info: AppFonts) -> UIFont {
        let fontName = info.getFontName()
        switch info {
        case let .regular(size):
            if let font = UIFont(name: fontName, size: size) {
                return font
            }
        case let .medium(size):
            if let font = UIFont(name: fontName, size: size) {
                return font
            }
        case let .bold(size):
            if let font = UIFont(name: fontName, size: size) {
                return font
            }
        }
        return UIFont.systemFont(ofSize: UIFont.systemFontSize)
    }
}
