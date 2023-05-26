//
//  Resources.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import Foundation

struct Resource<T: Codable> {
    let url: URL
    var method: NetworkMethod
    
    init(url: URL, method: NetworkMethod = .get) {
        self.url = url
        self.method = method
    }
}
