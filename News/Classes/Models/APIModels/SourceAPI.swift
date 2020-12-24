//
//  SourceAPI.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

struct SourceAPI {
    let id: String?
    let name: String?
}

extension SourceAPI: Convertable {
    typealias Target = Source

    func convert() -> Target {
        Target(name: name)
    }
}
