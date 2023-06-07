//
//  FavouritesListViewModelTests
//  GamesExplorerTests
//
//  Created by AhmedFitoh on 6/7/23.
//

import XCTest
@testable import GamesExplorer

final class FavouritesListViewModelTests: XCTestCase {

    private let viewModel = FavouritesListViewModel(favouritesService: FavouritesManagerMock())
    private let testGame = Game.readyList [0]

    override func setUpWithError() throws {
        addTestGameToFavourites()
    }

    override func tearDownWithError() throws {
        removeTestGameFromFavourites()
    }

    func testRetrieveFavourites() throws {
        viewModel.retrieveFavourites { isFavouritesEmpty in
            XCTAssertFalse(isFavouritesEmpty)
        }
    }

    func testRemoveFromFavourites() throws {
        viewModel.removeFromFavourites(id: testGame.id) { [weak self] in
            guard let self = self else {
                return
            }
            self.viewModel.retrieveFavourites { isFavouritesEmpty in
                let gameIsInFavourites = (self.viewModel.favourites.contains(where: { game in
                    game.id == self.testGame.id
                }))
                XCTAssertFalse(gameIsInFavourites)
            }
        }
    }
}

extension FavouritesListViewModelTests {
    private func addTestGameToFavourites() {
        FavouritesManagerMock().addToFavourites(testGame)
    }

    private func removeTestGameFromFavourites() {
        FavouritesManagerMock().removeFromFavourites(id: testGame.id)
    }
}
