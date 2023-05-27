//
//  GamesListViewModel.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import Foundation

class FavouritesListViewModel {

    private let favouritesService: FavouritesProvider!

    var favourites: [Game] = []

    init(favouritesService: FavouritesProvider = FavouritesManager()) {
        self.favouritesService = favouritesService
    }

    func retrieveFavourites(completion: @escaping (Bool)->()) {
        favourites = favouritesService.retrieveFavourites()
        completion(favourites.isEmpty)
    }

    func removeFromFavourites(id: Int, completion: @escaping ()->()) {
        favouritesService.removeFromFavourites(id: id)
        completion()
    }
}
