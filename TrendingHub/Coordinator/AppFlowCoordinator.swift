//
//  AppFlowCoordinator.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/24/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import UIKit

protocol FlowCoordinator {
    func start()
}

protocol RepositoryListDependencies {
    func createRepositoryListViewController(didSelect: @escaping RepositoryListViewDidSelectAction) -> RepositoryListViewController
    func createRepositoryDetailsViewController(repository: Repository) -> RepositoryDetailsViewController
}

// For simplicity used one flow - AppFlowCoordinator. Nested flows is a good practice.
// Though it can make an overhead here using it
class AppFlowCoordinator: FlowCoordinator {
    
    private let navigationController: UINavigationController
    private let dependencies: RepositoryListDependencies
    
    init(navigationController: UINavigationController, dependencies: RepositoryListDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let repositoryListViewController = dependencies.createRepositoryListViewController(didSelect: presentDetails(repository:))
        navigationController.setViewControllers([repositoryListViewController], animated: true)
    }
    
    func presentDetails(repository: Repository) {
        let viewController = dependencies.createRepositoryDetailsViewController(repository: repository)
        navigationController.pushViewController(viewController, animated: true)
    }
}


