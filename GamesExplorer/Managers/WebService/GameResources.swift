//
//  GameResources.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import Foundation

struct GamesExplorerURLComponents {
    static let scheme: String = {
        #if DEVELOPMENT
        return "https"
        #else
        return "https"
        #endif
    } ()

    static let host: String = {
        #if DEVELOPMENT
        return "api.rawg.io"
        #else
        return "api.rawg.io"
        #endif
    } ()

    static let apiKey: String = {
        #if DEVELOPMENT
        return "3be8af6ebf124ffe81d90f514e59856c"
        #else
        return "3be8af6ebf124ffe81d90f514e59856c"
        #endif
    } ()
}

enum APIGamesURLs {
    static func gamesDefaultURL(page: Int) -> URL? {
        return URLManager.shared.GamesURL(with: "/api/games", query: [
            "page_size": "\(URLManager.shared.pageSize)",
            "page": "\(page)",
            "key": GamesExplorerURLComponents.apiKey
        ])
    }
    
    
    static func gameDetails(gameId: Int) -> URL? {
        return URLManager.shared.GamesURL(with: "/api/games/\(gameId)", query: [
            "key": GamesExplorerURLComponents.apiKey
        ])
    }
    
    
    
    static func searchGamesURL(page: Int, search: String) -> URL? {
        return URLManager.shared.GamesURL(with: "/api/games", query: [
            "page_size": "\(URLManager.shared.pageSize)",
            "page": "\(page)",
            "search": search,
            "key": GamesExplorerURLComponents.apiKey,
            
        ])
    }
}

struct GameResources {
    static func gamesListResource(page: Int) -> Resource<GamesResponse>? {
        guard let url = APIGamesURLs.gamesDefaultURL(page: page) else { return nil }
        return Resource<GamesResponse>(url: url)
    }
    
    static func gamesDetailsResource(id: Int) -> Resource<GameDetailsModel>? {
        guard let url = APIGamesURLs.gameDetails(gameId: id) else { return nil }
        return Resource<GameDetailsModel>(url: url)
    }
    
    static func searchGamesResource(page: Int, search: String) -> Resource<GamesResponse>? {
        guard let url = APIGamesURLs.searchGamesURL(page: page, search: search) else { return nil }
        return Resource<GamesResponse>(url: url)
    }
}
