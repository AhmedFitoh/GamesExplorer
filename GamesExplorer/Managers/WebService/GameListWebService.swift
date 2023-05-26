//
//  GameListWebService.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import Foundation

struct GamesListWebService: GamesListServiceProtocol {
    
    func loadData(page: Int, search: String? = nil, completion: @escaping (Result<([Game], String?), NetworkError>) -> ()) {
        
        var resource: Resource<GamesResponse>?
        
        if let search = search {
            resource = GameResources.searchGamesResource(page: page, search: search)
        } else {
            resource = GameResources.gamesListResource(page: page)
        }
        
        guard let resource = resource else {
            return
        }
        NetworkManager.shared.load(resource: resource ) { result in
            switch result {
            case .success(let gamesResponse):
                let games = gamesResponse.results ?? []
                let next = gamesResponse.next
                completion(.success((games, next)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct GamesDetailsWebService:  GameDetailsApiServiceProtocol {
    func loadData(id: Int, completion: @escaping (Result<GameDetailsModel, NetworkError>) -> ()) {
        guard let resource = GameResources.gamesDetailsResource(id: id) else {
            completion(.failure(.invalidURL))
            return
        }
        NetworkManager.shared.load(resource: resource) { result in
            switch result {
            case .success(let gameDetails):
                completion(.success(gameDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
