//
//  ArticleAPI.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

struct ArticleAPI {
    let source: SourceAPI
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let imageURL: URL?
    let publishDate: String?
    let content: String?
}

extension ArticleAPI: Convertable {
    typealias Target = Article
    
    func convert() -> Target {
        Target(source: source.convert(),
               author: author,
               title: title,
               imageURL: imageURL,
               content: content)
    }
}
