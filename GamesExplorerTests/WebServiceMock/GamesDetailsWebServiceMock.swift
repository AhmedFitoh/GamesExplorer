//
//  GameDetailsApiServiceProtocolMock.swift
//  GamesExplorerTests
//
//  Created by AhmedFitoh on 6/7/23.
//

import Foundation
@testable import GamesExplorer

class GamesDetailsWebServiceSuccessMock: GameDetailsApiServiceProtocol {
    func loadData(id: Int,
                  completion: @escaping (Result<GamesExplorer.GameDetailsModel, GamesExplorer.NetworkError>) -> ()) {
        completion(.success(GameDetailsModel.readyGameDetails))
    }
}

class GamesDetailsWebServiceFailureMock: GameDetailsApiServiceProtocol {
    func loadData(id: Int,
                  completion: @escaping (Result<GamesExplorer.GameDetailsModel, GamesExplorer.NetworkError>) -> ()) {
        completion(.failure(.invalidURL))
    }
}
