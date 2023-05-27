//
//  GameDetailsViewModel.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import Foundation

protocol GameDetailsApiServiceProtocol {
    func loadData(id: Int, completion: @escaping (Result<GameDetailsModel, NetworkError>)->())
}

class GameDetailsViewModel {
    
    private let webService: GameDetailsApiServiceProtocol
    private let favouriteService: FavouritesProvider
    let selectedGame: Game
    
    private var gameDetails: GameDetailsModel?
    
    var isFavourite = false
    
    var redditLink: URL? {
        if let stringUrl = gameDetails?.redditURL,
           let url = URL(string: stringUrl) {
            return url
        } else {
            return nil
        }
    }

    var websiteLink: URL? {
        if let stringUrl = gameDetails?.website,
           let url = URL(string: stringUrl) {
            return url
        } else {
            return nil
        }
    }

    init(webService: GameDetailsApiServiceProtocol = GamesDetailsWebService(),
         favouriteService: FavouritesProvider = FavouritesManager(),
         selectedGame: Game) {
        self.webService = webService
        self.favouriteService = favouriteService
        self.selectedGame = selectedGame
        checkGameIfAddedToFavourites()
    }
    
    func fetchGameDetails(completion: @escaping (Result<GameDetailsModel, NetworkError>)->()) {
        webService.loadData(id: selectedGame.id) {[weak self] result in
            switch result {
            case .success(let gameDetails):
                self?.gameDetails = gameDetails
                completion(.success(gameDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

// MARK: Favourites

extension GameDetailsViewModel {
    func favouritesAction() {
        if isFavourite {
            removeFromFavourites()
        } else {
            addToFavourites()
        }
    }
    
    private func addToFavourites() {
        favouriteService.addToFavourites(selectedGame)
        isFavourite = true
    }
    
    private func removeFromFavourites() {
        favouriteService.removeFromFavourites(id: selectedGame.id)
        isFavourite = false
    }

    private func checkGameIfAddedToFavourites() {
        if let _ = favouriteService.retrieveFavourites()
            .first(where: { favouriteGame in favouriteGame.id == selectedGame.id}) {
            isFavourite = true
        }
    }
}
