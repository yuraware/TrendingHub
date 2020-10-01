//
//  RepositoryListViewController.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/26/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryListViewController: UIViewController {

    private var viewModel: RepositoryListViewModel!
    private var didSelect: RepositoryListViewDidSelectAction!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    
    // `dataSource` captures items to rendred
    // It prevents frequent changing of items emitted by viewModel
    // due to async nature of update it can corrupt the data consistency in tableview
    var dataSource = [RepositoryViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindUI()
    }
    
    private func bindUI() {
        viewModel.itemsRelay.observeOn(MainScheduler.instance).subscribe {
            [weak self] items in
            guard let self = self else { return }
            self.dataSource = items.element ?? [RepositoryViewModel]()
            
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        searchBar.rx.text
            .throttle(.seconds(1), latest: true, scheduler: MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe { [weak self]  event in
                guard let self = self else { return }
                self.viewModel.startSearch(searchTerm: event.element!)
            
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

extension RepositoryListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.reuseIdentifier, for: indexPath) as? RepositoryTableViewCell else {
            fatalError()
        }
        
        cell.fill(repositoryViewModel: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(item: dataSource[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

