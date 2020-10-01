//
//  RepositoryViewModel.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/28/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol RepositoryViewModel {
    var projectName: String { get }
    var starsCount: String { get }
    var projectDescription: String { get }
    
    var authorName: String? { get }
    var authorAvatarURL: URL? { get }
    var readmeRelay: BehaviorRelay<String?> { get }
}

class RepositoryViewModelImpl : RepositoryViewModel {
    
    let projectName: String
    let starsCount: String
    let projectDescription: String
    
    let authorName: String?
    let authorAvatarURL: URL?
    
    let readmeRelay = BehaviorRelay<String?>(value: "")
    
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
        
        let url = repository.url.replacingOccurrences(of: "https://github.com/", with: "https://raw.githubusercontent.com/")
        if let readmeURL = URL(string: url + "/master/README.md") {
            let task = URLSession.shared.dataTask(with: readmeURL) {
                (data, response, error) in
                if let data = data, let readmeString = String(data: data, encoding: .utf8) {
                    if readmeString.contains("404: Not Found") == false {
                        self.readmeRelay.accept(readmeString)
                    } else {
                        self.readmeRelay.accept(nil)
                    }
                }
            }
            task.resume()
        }
    }
}
