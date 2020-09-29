//
//  RepositoryListViewModel.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/23/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

protocol RepositoryListViewModelInput {
    func viewWillAppear()
    func didSelect(item: RepositoryViewModel)
}

protocol RepositoryListViewModel : RepositoryListViewModelInput {
    var title: String { get }
}

final class RepositoryListViewModelImpl : RepositoryListViewModel {
    
    let title = "Github Trends"
    
    private let fetchUseCase : FetchRepositoriesUseCase
    
    init(fetchUseCase : FetchRepositoriesUseCase) {
        self.fetchUseCase = fetchUseCase
    }
}

extension RepositoryListViewModelImpl {
    func viewWillAppear() {
        
    }
    
    func didSelect(item: RepositoryViewModel) {
        
    }
}
