//
//  DataManagerError.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

final class DataManagerError: AppError {
    static func newsAPIError(error: Error) -> DataManagerError {
        DataManagerError(description: "Something with loading news", underlying: error)
    }
    
    static func imageDownloaderError(error: Error) -> DataManagerError {
        DataManagerError(description: "Something with loading images", underlying: error)
    }
}
