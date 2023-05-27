//
//  Constants.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import Foundation
import UIKit


enum Constants {

    enum Images {
        static let logo = UIImage(named: "logo")
        static let playIcon = UIImage(named: "PlayIcon")
        static let favoriteIcon = UIImage(named: "FavoriteIcon")
    }
}

enum Localization {
    
    enum RootTabBar {
        static var gamesScreenTitle: String {return "Games"}
        static var favouritesScreenTitle: String {return "Favourites"}
    }
    
    enum GamesList {
        static var searchBarPlaceholder: String {return "Search for the games"}

    }

    enum GameDetails {
        static var visitReddit = "Visit reddit"
        static var visitWebsite = "Visit website"
        static var gameDescription = "Game Description"
        static var favourite = "Favourite"
        static var favourited = "Favourited"
    }
    
    enum FavouritesList {
        static var screenTitle: String {return "Favourites"}
        static var removeFromFavouritesAlert: String {return "Are you sure you want to remove %@ from favourites ?"}
        
        static var emptyFavouritesLabel: String {return "There is no favourites found"}
    }
}
