//
//  RepositoryDetailsViewController.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/26/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import UIKit
import AlamofireImage
import WebKit
import RxSwift
import RxRelay

class RepositoryDetailsViewController: UIViewController {

    private var viewModel: RepositoryViewModel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var readmeLabel: UILabel!
    @IBOutlet weak var readmeWebView: WKWebView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = viewModel.projectName
        nameLabel.text = viewModel.authorName
        descriptionLabel.text = viewModel.projectDescription
        avatar.layer.cornerRadius = avatar.layer.bounds.size.width/2
        avatar.layer.masksToBounds = true
        self.readmeWebView.isHidden = true
        
        if let authorAvatarURL = viewModel.authorAvatarURL {
            avatar.af.setImage(withURL: authorAvatarURL)
        }
        
        viewModel.readmeRelay.observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let self = self else { return }
                if let html = event.element as? String {
                    self.readmeWebView.isHidden = false
                    self.readmeWebView.loadHTMLString(html, baseURL: nil)
                } else {
                    self.readmeLabel.text = "No Readme file"
                }
                
            }.disposed(by: disposeBag)
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
