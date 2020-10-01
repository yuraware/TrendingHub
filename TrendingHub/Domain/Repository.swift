//
//  Repository.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/21/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import Foundation

struct Repository : Codable, Equatable {
    let stars: Int
    let name: String
    let description: String
    let builtBy : [User]
}

extension Repository {
    var author : User? {
        builtBy.first
    }
}

func ==(lhs: Repository, rhs: Repository) -> Bool {
    return lhs.name == rhs.name
}
