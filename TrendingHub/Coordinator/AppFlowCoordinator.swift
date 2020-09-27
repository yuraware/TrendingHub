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
    func createRepositoryListViewController() -> RepositoryListViewController
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
        let repositoryListViewController = dependencies.createRepositoryListViewController()
        navigationController.setViewControllers([repositoryListViewController], animated: true)
    }
}


