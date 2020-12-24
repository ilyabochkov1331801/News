//
//  DataManagerError.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

final class DataManagerError: AppError {
    static func newsAPIError(error: Error) -> Self {
        Self(description: "News api data manager error", underlying: error)
    }
}
