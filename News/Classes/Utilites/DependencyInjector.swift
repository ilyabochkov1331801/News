//
//  DependencyInjector.swift
//  News
//
//  Created by Alena Niastsiorkina on 25.12.20.
//

import Foundation

protocol Resolvable { }

protocol DependencyInjector: class {
    var container: [Resolvable] { get set }
    
    func register(_ some: Resolvable)
    func resolve<Some: Resolvable>(_ type: Some.Type) -> Some
}

extension DependencyInjector {
    func resolve<Some: Resolvable>(_ type: Some.Type) -> Some {
        guard let resolved = (container.compactMap { $0 as? Some }).first else {
            fatalError("Can't resolve \(Some.self)")
        }
        return resolved
    }
    
    func register(_ some: Resolvable) {
        container.append(some)
    }
}
