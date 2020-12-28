//
//  DetailsController.swift
//  News
//
//  Created by Alena Niastsiorkina on 26.12.20.
//

import UIKit

final class DetailsController: Controller<DetailsView> {
    private let article: Article
    
    var openLink: ((URL) -> Void)?
    var closeTransition: (() -> Void)?
    
    init(article: Article, title: String) {
        self.article = article
        
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        contentView.set(article: article)
        contentView.closeButtonAction = closeTransition
        
        contentView.sourceButtonAction = { [weak self] in
            if let link = self?.article.sourceURL {
                self?.openLink?(link)
            }
        }
        
        navigationItem.hidesBackButton = true
    }
}
