//
//  Article.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

struct Article {
    let source: Source?
    let author: String?
    let title: String?
    let imageURL: URL?
    let content: String?
}

extension Article: ConvertableTarget { }
