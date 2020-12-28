//
//  Article.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

struct Article {
    let author: String?
    let title: String?
    let sourceURL: URL?
    let imageURL: URL?
    let content: String?
    let date: Date?
}

extension Article: ConvertableTarget { }
