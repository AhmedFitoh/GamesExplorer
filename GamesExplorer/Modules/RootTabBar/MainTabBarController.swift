//
//  RootTabBar.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import UIKit

class RootTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        viewControllers = [createGamesList(), createFavouritesList()]
    }

    func setupAppearance() {
        UITabBar.appearance().tintColor = AppTheme.shared.tabBarTintColor
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor  = AppTheme.shared.tabBarBackgroundColor
            UITabBar.appearance().standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
    }
    
    func createGamesList() -> UINavigationController {
        let gamesListViewController = GamesListViewController()
        return searchNC
    }
    
    
    func createFavouritesList() -> UINavigationController {
        let favouritesViewController = FavouritesListViewController()
        return favoritesNavigationController
    }
}
