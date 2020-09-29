//
//  RepositoryListViewModel.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/23/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import RxSwift
import RxRelay

protocol RepositoryListViewModelInput {
    func viewWillAppear()
    func didSelect(item: RepositoryViewModel)
}

protocol RepositoryListViewModel : RepositoryListViewModelInput {
    var title: String { get }
    var items: BehaviorRelay<[RepositoryViewModel]> { get }
}

final class RepositoryListViewModelImpl : RepositoryListViewModel {
    
    let items = BehaviorRelay<[RepositoryViewModel]>(value: [])
    
    let title = "Github Trends"
    
    private let fetchUseCase : FetchRepositoriesUseCase
    
    init(fetchUseCase : FetchRepositoriesUseCase) {
        self.fetchUseCase = fetchUseCase
    }
}

extension RepositoryListViewModelImpl {
    func viewWillAppear() {
        
        _ = fetchUseCase.fetch { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let repositories):   
                self.items.accept(repositories.map { RepositoryViewModel(repository: $0) })
            case .failure: break
            }
        }
    }
    
    func didSelect(item: RepositoryViewModel) {
        
    }
}
