//
//  RepositoryViewModel.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/28/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import UIKit

protocol RepositoryViewModel {
    var projectName: String { get }
    var starsCount: String { get }
    var projectDescription: String { get }
    
    var authorName: String? { get }
    var authorAvatarURL: URL? { get }
}

struct RepositoryViewModelImpl : RepositoryViewModel {
    
    let projectName: String
    let starsCount: String
    let projectDescription: String
    let authorName: String?
    let authorAvatarURL: URL?
    
    init(repository: Repository) {
        projectName = repository.name
        starsCount = "\(repository.stars) stars"
        projectDescription = repository.description
        authorName = repository.author?.username
        if let avatarPath = repository.author?.avatar, let url = URL(string: avatarPath) {
            authorAvatarURL = url
        } else {
            authorAvatarURL = nil
        }
    }
}
