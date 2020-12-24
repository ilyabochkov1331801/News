//
//  AppError.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

open class AppError: Error {
    private let description: String
    private let underlying: Error?
    private var domain: String { String(describing: self) }
    
    public init(description: String, underlying: Error? = nil) {
        self.description = description
        self.underlying = underlying
    }
    
    func userDescription() -> String {
        domain + .separator + description
    }
    
    func fullUserDescription() -> String {
        userDescription() + (
            underlying.flatMap { .newLine + (($0 as? AppError)?.fullUserDescription() ?? $0.localizedDescription ) } ?? ""
        )
    }
}
