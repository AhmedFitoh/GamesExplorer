//
//  Game.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import Foundation

struct GamesResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Game]?
}

struct Game: Codable {
    let id: Int
    let name: String?
    let backgroundImage: String?
    let metacritic: Int?
    let genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case backgroundImage = "background_image"
        case id, name, metacritic, genres
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

extension Game: GameCellUIModel {
    var title: String { return name ?? "" }
    var genresText: String { return genres?.compactMap(\.name).joined(separator: " , ") ?? "" }
    var imageURL: String  { return backgroundImage ?? "" }
    var ratingText: String { return String(metacritic ?? 0) }
}
