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
    func startSearch(searchTerm: String?)
}

protocol RepositoryListViewModel : RepositoryListViewModelInput {
    var title: String { get }
    var itemsRelay: BehaviorRelay<[RepositoryViewModel]> { get }
}

typealias RepositoryListViewDidSelectAction = (Repository) -> Void

final class RepositoryListViewModelImpl : RepositoryListViewModel {
    
    let itemsRelay = BehaviorRelay<[RepositoryViewModel]>(value: [])
    private var cachedItems = [Repository]()
    
    let title = "Github Trends"
    
    private let fetchUseCase : FetchRepositoriesUseCase
    private let didSelectAction : RepositoryListViewDidSelectAction
    
    init(fetchUseCase : FetchRepositoriesUseCase, didSelect : @escaping RepositoryListViewDidSelectAction) {
        self.fetchUseCase = fetchUseCase
        didSelectAction = didSelect
    }
}

extension RepositoryListViewModelImpl {
    func viewWillAppear() {
        
        //TODO: add canceling of fetch before a new refresh
        fetchUseCase.fetch { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let repositories):
                self.cachedItems = repositories
                self.itemsRelay.accept(repositories.map { RepositoryViewModelImpl(repository: $0) })
            case .failure: break
            }
        }
    }
    
    func didSelect(item: RepositoryViewModel) {
        if let selectedRepository = cachedItems.filter({ $0.name == item.projectName }).first {
            didSelectAction(selectedRepository)
        }
    }
    
    func startSearch(searchTerm: String?) {
        guard let searchTerm = searchTerm, !searchTerm.isEmpty else {
            self.itemsRelay.accept(cachedItems.map { RepositoryViewModelImpl(repository: $0) })
            return
        }
        
        let term = searchTerm.lowercased()
        
        let filteredResult = cachedItems
            .filter({ $0.name.lowercased().contains(term) || $0.description.lowercased().contains(term)})
            .map({ RepositoryViewModelImpl(repository: $0) })
        self.itemsRelay.accept(filteredResult)
    }
}
