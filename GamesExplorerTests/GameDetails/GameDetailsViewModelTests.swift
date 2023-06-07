//
//  GameDetailsViewModel.swift
//  GamesExplorerTests
//
//  Created by AhmedFitoh on 6/7/23.
//

import XCTest
@testable import GamesExplorer

final class GameDetailsViewModelTests: XCTestCase {

    private var viewModel: GameDetailsViewModel!

    func testFavouriteAction() throws {
        viewModel = GameDetailsViewModel(favouriteService: FavouritesManagerMock(),
                                         selectedGame: Game.readyList [0])

        let currentFavouriteState = viewModel.isFavourite
        viewModel.favouritesAction()
        XCTAssertTrue(viewModel.isFavourite == !currentFavouriteState)
    }

    func testFetchGameDetailsSuccessReturnsGameDetails() throws {
        viewModel = GameDetailsViewModel(webService: GamesDetailsWebServiceSuccessMock(),
                                         favouriteService: FavouritesManagerMock(),
                                         selectedGame: Game.readyList [0])
        viewModel.fetchGameDetails { result in
            switch result{
            case .success(_):
                XCTAssert(true)
            default:
                XCTAssert(false)
            }
        }
    }

    func testFetchGameDetailsFailureReturnsError() throws {
        viewModel = GameDetailsViewModel(webService: GamesDetailsWebServiceFailureMock(),
                                         favouriteService: FavouritesManagerMock(),
                                         selectedGame: Game.readyList [0])
        viewModel.fetchGameDetails { result in
            switch result{
            case .failure(_):
                XCTAssert(true)
            default:
                XCTAssert(false)
            }
        }
    }
}
