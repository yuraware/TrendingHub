//
//  RepositoryListDIContainer.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/23/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

class AppDIContainer {
    func createReposityListViewModel(didSelect: @escaping RepositoryListViewDidSelectAction) -> RepositoryListViewModel {
        return RepositoryListViewModelImpl(fetchUseCase: createFetchRepositoriesUseCase(), didSelect: didSelect)
    }
    
    func createReposityViewModel(repository: Repository) -> RepositoryViewModel {
           return RepositoryViewModelImpl(repository: repository)
    }
    
    func createFetchRepositoriesUseCase() -> FetchRepositoriesUseCase {
        return APIFetchRepositoriesUseCase(apiRepository: createAPIRepository())
    }
    
    func createAPIRepository() -> APIRepository {
        return APIDataRepository()
    }
}

extension AppDIContainer: RepositoryListDependencies {

    func createRepositoryListViewController(didSelect: @escaping RepositoryListViewDidSelectAction) -> RepositoryListViewController {
        return RepositoryListViewController
            .viewController(with: createReposityListViewModel(didSelect: didSelect))
    }
    
    func createRepositoryDetailsViewController(repository: Repository) -> RepositoryDetailsViewController {
        return RepositoryDetailsViewController.viewController(with: createReposityViewModel(repository: repository))
    }
}
