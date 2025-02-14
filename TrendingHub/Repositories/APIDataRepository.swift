//
//  APIDataRepository.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/25/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import Foundation

public protocol CancellableTask {
    func cancel()
}


enum APIError: Error {
    case invalidJSON
    case noData
}

extension URLSessionTask: CancellableTask { }

protocol APIRepository {
    func fetchRepositories(completion: @escaping (Result<[Repository], APIError>) -> Void) -> CancellableTask
}

class APIDataRepository: APIRepository {
    
    let fetchTrendingEndpoint = "https://ghapi.huchen.dev/repositories"
    
    func fetchRepositories(completion: @escaping (Result<[Repository], APIError>) -> Void) -> CancellableTask {

        guard let url = URL(string: fetchTrendingEndpoint) else {
            fatalError("Can't construct URL")
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            if let repositoriesList = try? JSONDecoder().decode(Array<Repository>.self, from: data) {
                completion(.success(repositoriesList))
            } else {
                completion(.failure(.invalidJSON))
            }
        }
        task.resume()
        
        return task
    }
}
