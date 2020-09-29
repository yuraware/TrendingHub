//
//  RepositoryTableViewCell.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/23/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import UIKit

final class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var projectDescriptionLabel: UILabel!
    
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
/*
 final class MoviesQueriesItemCell: UITableViewCell {
     static let height = CGFloat(50)
     static let reuseIdentifier = String(describing: MoviesQueriesItemCell.self)

     @IBOutlet private var titleLabel: UILabel!
     
     func fill(with suggestion: MoviesQueryListItemViewModel) {
         self.titleLabel.text = suggestion.query
     }
 }

 */
