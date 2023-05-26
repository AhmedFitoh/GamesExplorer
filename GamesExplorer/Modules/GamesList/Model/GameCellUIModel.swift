//
//  GameCellUIModel.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import Foundation
protocol GameCellUIModel {
    var title: String { get }
    var genresText: String { get }
    var imageURL: String { get }
    var ratingText: String { get }
}
