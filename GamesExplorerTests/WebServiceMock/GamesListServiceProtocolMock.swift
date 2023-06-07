//
//  GamesListServiceProtocolMock.swift
//  GamesExplorerTests
//
//  Created by AhmedFitoh on 5/28/23.
//

import Foundation
@testable import GamesExplorer

class GamesListServiceProtocolSuccessMock: GamesListServiceProtocol {
    func loadData(page: Int,
                  search: String?,
                  completion: @escaping (Result<([GamesExplorer.Game], String?), GamesExplorer.NetworkError>) -> ()) {
        completion(.success((Game.readyList, nil)))
    }
}

class GamesListServiceProtocolFailureMock: GamesListServiceProtocol {
    func loadData(page: Int,
                  search: String?,
                  completion: @escaping (Result<([GamesExplorer.Game], String?), GamesExplorer.NetworkError>) -> ()) {
        completion(.failure(.invalidURL))
    }
}
