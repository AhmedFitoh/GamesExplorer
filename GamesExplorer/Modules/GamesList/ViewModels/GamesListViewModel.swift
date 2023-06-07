//
//  GamesListViewModel.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import Foundation

class GamesListViewModel {

    private var webService: GamesListServiceProtocol!
    /// Save IDs of opened game details 
    private var openGameDetailsHistory: [Int: Bool] = [:]

    var isLoading = false
    var games: [Game] = []
    // Pagination
    var next: String? = ""
    var currentPage = 0
    
    // Search
    var searchText: String? = nil

    var reloadGamesTableAction: (([IndexPath]?)->())?
    var showAlertAction: ((String)->())?

    init(webService: GamesListServiceProtocol = GamesListWebService()) {
        self.webService = webService
    }

    private func resetFetchingState() {
        searchText = nil
        currentPage = 0
        games = []
        next = ""
        reloadGamesTableAction?(nil)
    }

    private func generateAddedGamesIndexPaths(_ games: [Game]) -> [IndexPath] {
        let currentGamesCount = self.games.count
        let newGamesCount = games.count
        var newIndices: [IndexPath] = []
        for index in currentGamesCount..<(currentGamesCount + newGamesCount) {
            newIndices.append(.init(row: index, section: 0))
        }
        return newIndices
    }
}

//MARK: - Fetch Data

extension GamesListViewModel {
    
    func fetchMoreGames() {
        guard isLoading == false , next != nil else {return}
        currentPage += 1
        loadData(page: currentPage)
    }

    private func loadData(page: Int) {
        isLoading = true
        webService.loadData(page: page, search: searchText) { [weak self] result in
            guard let self = self else {return}
            self.isLoading = false
            switch result {
            case .success((let games, let next)):
                let newGamesIndexPaths = self.generateAddedGamesIndexPaths(games)
                self.games.append(contentsOf: games)
                self.next = next
                self.reloadGamesTableAction?(newGamesIndexPaths)
            case .failure(let error):
                self.showAlertAction?(error.rawValue)
                self.reloadGamesTableAction?(nil)
            }
        }
    }
}

//MARK: - Search

extension GamesListViewModel {
    func setSearchTitle(_ title: String?) {
        resetFetchingState()
        searchText = title
    }
}

//MARK: - GameDetails History

extension GamesListViewModel {
    func userDidOpenGame(at index: Int) {
        openGameDetailsHistory [games [index].id] = true
    }

    func didUserOpenGame(at index: Int) -> Bool {
        return openGameDetailsHistory [games [index].id] ?? false
    }
}
