//
//  NewsArticlesAPI.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

struct NewsArticlesAPI {
    let status: String
    let totalResults: Int
    let articles: [ArticleAPI]
}

extension NewsArticlesAPI: Convertable {
    typealias Target = NewsArticles
    
    func convert() -> Target {
        Target(articles: articles.map { $0.convert() })
    }
}
