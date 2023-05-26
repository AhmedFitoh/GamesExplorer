//
//  AppFonts.swift
//  GamesExplorer
//
//  Created by AhmedFitoh on 5/26/2023.
//

import Foundation

enum AppFonts {
    case regular(size: CGFloat)
    case medium(size: CGFloat)
    case bold(size: CGFloat)

    func getFontName() -> String {
        switch self {
        case .regular:
            return "SFProText-Regular"
        case .medium:
            return "SFProText-Medium"
        case .bold:
            return "SFProText-Bold"
        }
    }
}
