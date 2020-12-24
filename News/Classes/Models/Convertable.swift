//
//  Convertable.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

protocol ConvertableTarget { }

protocol Convertable: Codable {
    associatedtype Target: ConvertableTarget
    func convert() -> Target
}
