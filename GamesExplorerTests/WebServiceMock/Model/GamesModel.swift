//
//  GamesModel.swift
//  GamesExplorerTests
//
//  Created by AhmedFitoh on 5/28/23.
//

import Foundation
@testable import GamesExplorer

extension Game {
   static var readyList: [Game]  {
        return [
            .init(id: 3498,
                  name: "Grand Theft Auto V",
                  backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
                  metacritic: 92,
                  genres: [.init(id: 4, name: "Action"),
                           .init(id: 3, name: "Adventure")
                  ]),
            .init(id: 3328,
                  name: "The Witcher 3: Wild Hunt",
                  backgroundImage: "https://media.rawg.io/media/games/618/618c2031a07bbff6b4f611f10b6bcdbc.jpg",
                  metacritic: 92,
                  genres: [.init(id: 5, name: "RPG")]
                 )
        ]
    }
}
