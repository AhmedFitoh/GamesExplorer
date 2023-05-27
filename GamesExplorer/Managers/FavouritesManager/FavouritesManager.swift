//
//  FavouritesManager.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import Foundation

protocol FavouritesProvider {
    func addToFavourites(_ game: Game)
    func removeFromFavourites(id: Int)
    func retrieveFavourites() -> [Game]
}

class FavouritesManager: FavouritesProvider {

    private let defaults = UserDefaults.standard
    private let favouritesKey = "favourites"

    func addToFavourites(_ game: Game) {
        var currentFavourites = retrieveFavourites()
        currentFavourites.append(game)
        saveFavourites(list: currentFavourites)
    }

    func removeFromFavourites(id: Int) {
        var currentFavourites = retrieveFavourites()
        currentFavourites.removeAll { $0.id == id }
        saveFavourites(list: currentFavourites)
    }

    func retrieveFavourites() -> [Game] {
        if let favouritesData = defaults.object(forKey: favouritesKey) as? Data,
           let favourites = try? JSONDecoder().decode([Game].self, from: favouritesData) {
            return favourites
        } else {
            return []
        }
    }

    private func saveFavourites(list: [Game]){
        let data =  try? JSONEncoder().encode(list)
        defaults.set(data, forKey: favouritesKey)
    }
}
