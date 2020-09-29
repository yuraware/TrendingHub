//
//  RepositoryTableViewCell.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/23/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import UIKit

final class RepositoryTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: RepositoryTableViewCell.self)

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var projectDescriptionLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fill(repositoryViewModel: RepositoryViewModel) {
        projectNameLabel.text = repositoryViewModel.projectName
        starCountLabel.text = repositoryViewModel.starsCount
        projectDescriptionLabel.text = repositoryViewModel.projectDescription
    }
}

