//
//  RepositoryListViewController.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/26/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import UIKit
import RxSwift

class RepositoryListViewController: UIViewController {

    private var viewModel: RepositoryListViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        
        viewModel.items.observeOn(MainScheduler.instance).subscribe { [weak self] _ in
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    static func viewController(with viewModel: RepositoryListViewModel) -> RepositoryListViewController {
        let storyboard = UIStoryboard(name: String(describing: Self.self), bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? RepositoryListViewController else {
            fatalError("Failure while instantiating viewController \(Self.self)")
        }
        viewController.viewModel = viewModel
        return viewController
    }
}
