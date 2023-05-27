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
        gamesListViewController.navigationItem.title = Localization.RootTabBar.gamesScreenTitle
        gamesListViewController.tabBarItem = UITabBarItem(title: Localization.RootTabBar.gamesScreenTitle,
                                           image:  Constants.Images.playIcon!,
                                           tag: 0)
        let searchNC = UINavigationController(rootViewController: gamesListViewController)
        return searchNC
    }
    
    
    func createFavouritesList() -> UINavigationController {
        let favouritesViewController = FavouritesListViewController()
        favouritesViewController.navigationItem.title = Localization.RootTabBar.favouritesScreenTitle
        favouritesViewController.tabBarItem = UITabBarItem(title: Localization.RootTabBar.favouritesScreenTitle,
                                                           image: Constants.Images.favoriteIcon!,
                                                           tag: 1)
        let favoritesNavigationController = UINavigationController(rootViewController: favouritesViewController)
        return favoritesNavigationController
    }
}
