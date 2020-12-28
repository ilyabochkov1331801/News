//
//  ArticleAPI.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

struct ArticleAPI {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

extension ArticleAPI: Convertable {
    typealias Target = Article
    
    func convert() -> Target {
        Target(author: author,
               title: title,
               sourceURL: URL(string: url ?? ""),
               imageURL: URL(string: urlToImage ?? ""),
               content: content,
               date: DateFormatters.apiDateFormatter.date(from: publishedAt ?? ""))
    }
}
