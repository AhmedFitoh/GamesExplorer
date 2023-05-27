//
//  GameDetails.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import Foundation

struct GameDetailsModel: Codable {
    let id: Int
    let redditURL: String?
    let website: String?
    let name: String?
    let gameDescription: String?
    let backgroundImage: String?
    
    enum CodingKeys: String, CodingKey {
        case backgroundImage = "background_image"
        case gameDescription = "description"
        case name, id, website
        case redditURL = "reddit_url"
    }
}
