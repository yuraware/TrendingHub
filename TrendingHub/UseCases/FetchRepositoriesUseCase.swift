//
//  FetchRepositoriesUseCase.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/27/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import UIKit

protocol FetchRepositoriesUseCase {
    func
        fetch(completion: @escaping (Result<[Repository], APIError>) -> Void) -> CancellableTask
}

class APIFetchRepositoriesUseCase : FetchRepositoriesUseCase {
    
    private let apiRepository: APIRepository
    
    init(apiRepository: APIRepository) {
        self.apiRepository = apiRepository
    }
    
    func fetch(completion: @escaping (Result<[Repository], APIError>) -> Void) -> CancellableTask {
        return apiRepository.fetchRepositories(completion: completion)
    }
}
