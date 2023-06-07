//
//  WebService.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import UIKit


enum NetworkMethod: String {
    case get = "GET"
    case post = "POST"
}


enum NetworkError: String, Error {
    case invalidURL = "This url is invalid. Please try again."
    case invalidResponse = "Invalid Response from the server please try again."
}


class NetworkManager {
    
    static let shared   = NetworkManager()
    private let decoder =  JSONDecoder()

    private init() {}

    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var request = URLRequest(url: resource.url)
        #if DEBUG
        print(resource.url)
        #endif
        request.httpMethod = resource.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .returnCacheDataElseLoad
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidURL))
                return
            }
            
            if let result = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(result))
            } else {
                completion(.failure(.invalidResponse))
            }
            
        }.resume()
        
    }
    
}

extension NetworkManager {
    func downloadImage(from url: URL, completion: @escaping (Data?) -> ())  {
        let urlSession = URLSession(configuration: .ephemeral)
        urlSession.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(nil)
                return }
            completion(data)
            return
        }.resume()
    }
}
