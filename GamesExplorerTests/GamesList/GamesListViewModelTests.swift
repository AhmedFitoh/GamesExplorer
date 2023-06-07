//
//  GamesListViewModelTests.swift
//  GamesExplorerTests
//
//  Created by AhmedFitoh on 5/28/23.
//

import XCTest
@testable import GamesExplorer

final class GamesListViewModelTests: XCTestCase {

    private var viewModel: GamesListViewModel!

    func testFetchGamesSuccess() throws {
        viewModel = GamesListViewModel(webService: GamesListServiceProtocolSuccessMock())

        viewModel.reloadGamesTableAction = {newIndexPaths in
            XCTAssertEqual(newIndexPaths?.count ?? 0, Game.readyList.count)
        }
        viewModel.fetchMoreGames()
    }

    func testFetchGamesFailure() throws {
        viewModel = GamesListViewModel(webService: GamesListServiceProtocolFailureMock())

        viewModel.reloadGamesTableAction = {newIndexPaths in
            XCTAssertNil(newIndexPaths)
        }
        viewModel.fetchMoreGames()
    }

    func testUserGameDetailsHistory() throws {
        viewModel = GamesListViewModel(webService: GamesListServiceProtocolSuccessMock())

        viewModel.fetchMoreGames()

        viewModel.userDidOpenGame(at: 0)
        viewModel.userDidOpenGame(at: 1)

        XCTAssertTrue(viewModel.didUserOpenGame(at: 0))
        XCTAssertTrue(viewModel.didUserOpenGame(at: 1))
    }
}
