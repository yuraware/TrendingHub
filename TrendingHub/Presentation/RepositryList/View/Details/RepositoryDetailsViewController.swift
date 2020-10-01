//
//  RepositoryDetailsViewController.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/26/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {

    private var viewModel: RepositoryViewModel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var readmeTextView: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = viewModel.projectName
        nameLabel.text = viewModel.authorName
        descriptionLabel.text = viewModel.projectDescription
    }
    
    static func viewController(with viewModel: RepositoryViewModel) -> RepositoryDetailsViewController {
           let storyboard = UIStoryboard(name: String(describing: Self.self), bundle: nil)
           guard let viewController = storyboard.instantiateInitialViewController() as? RepositoryDetailsViewController else {
               fatalError("Failure while instantiating viewController \(Self.self)")
           }
           viewController.viewModel = viewModel
           return viewController
       }
}
