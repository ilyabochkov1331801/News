//
//  ServiceError.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

final class ServiceError: AppError {
    static func newsError(error: Error) -> Self {
        Self(description: "News service error", underlying: error)
    }
}
