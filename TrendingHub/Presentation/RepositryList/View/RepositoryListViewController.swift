//
//  RepositoryListViewController.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/26/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import UIKit

class RepositoryListViewController: UIViewController {

    private var viewModel: RepositoryListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
    }
    
    static func viewController(with viewModel: RepositoryListViewModel) -> RepositoryListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Failure while instantiating viewContrller \(Self.self)")
        }
        viewController.viewModel = viewModel
        return viewController
    }
}
