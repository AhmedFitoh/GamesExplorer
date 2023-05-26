//
//  AppTheme.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import UIKit

enum Theme {
    case standard
}

struct AppTheme {
    
    static let shared: AppTheme = AppTheme()
    private init() {}
    
    var theme: Theme = .standard
    
    var navigationBarColor : UIColor   {
        switch theme {
        case .standard:
            return UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.92)
        }
    }

    var navBarTitleColor : UIColor   {
        switch theme {
        case .standard:
            return .black
        }
    }

    var navBarTintColor : UIColor   {
        switch theme {
        case .standard:
            return .black
        }
    }

    var gamesBackgroundColor: UIColor{
        switch theme {
        case .standard:
            return UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        }
    }

    var gamesSelectedBackgroundColor: UIColor{
        switch theme {
        case .standard:
            return UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.00)
        }
    }

    var tabBarTintColor : UIColor   {
        switch theme {
        case .standard:
            return UIColor(red: 0.063, green: 0.392, blue: 0.737, alpha: 1)
        }
    }

    var tabBarBackgroundColor : UIColor   {
        switch theme {
        case .standard:
            return UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.92)
        }
    }
}
