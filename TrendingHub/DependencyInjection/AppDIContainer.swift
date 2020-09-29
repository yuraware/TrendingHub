//
//  RepositoryListDIContainer.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/23/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

class AppDIContainer {
    func createReposityListViewModel() -> RepositoryListViewModel {
        return RepositoryListViewModelImpl(fetchUseCase: createFetchRepositoriesUseCase())
    }
    
    func createFetchRepositoriesUseCase() -> FetchRepositoriesUseCase {
        return APIFetchRepositoriesUseCase(apiRepository: createAPIRepository())
    }
    
    func createAPIRepository() -> APIRepository {
        return APIDataRepository()
    }
}

extension AppDIContainer: RepositoryListDependencies {
    
    func createRepositoryListViewController() -> RepositoryListViewController {
        return RepositoryListViewController.viewController(with: createReposityListViewModel())
    }
    
    
}
