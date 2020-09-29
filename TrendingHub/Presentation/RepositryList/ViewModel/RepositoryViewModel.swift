//
//  RepositoryViewModel.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/28/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import UIKit

struct RepositoryViewModel {
    let projectName: String
    let starsCount: String
    let projectDescription: String
    
    init(repository: Repository) {
        projectName = repository.name
        starsCount = "\(repository.stars)"
        projectDescription = repository.description
    }
}
