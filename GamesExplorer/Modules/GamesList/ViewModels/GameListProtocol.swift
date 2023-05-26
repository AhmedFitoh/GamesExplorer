//
//  GameListProtocol.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import Foundation
protocol GamesListServiceProtocol {
    func loadData(page: Int, search: String? , completion: @escaping (Result<([Game], String?), NetworkError>)->())
}
