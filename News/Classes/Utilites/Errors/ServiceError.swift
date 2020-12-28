//
//  ServiceError.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

final class ServiceError: AppError {
    static func newsError(error: Error) -> ServiceError {
        ServiceError(description: "Somesthing with getting news", underlying: error)
    }
}
