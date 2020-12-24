//
//  APIError.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

final class APIError: AppError {
    static func taskError(error: Error) -> APIError {
        APIError(description: "Data task finished with error", underlying: error)
    }
    
    static func buildRequestError(from endpoint: String) -> APIError {
        APIError(description: "Can't build request from endpoint - \(endpoint)")
    }
    
    static func invalidResponse(with code: Int?) -> APIError {
        APIError(description: "Invalid response code - \(String(describing: code))")
    }
    
    static func decodeError(from ednpoing: String, type: String, error: Error) -> APIError {
        APIError(description: "Can't decode response from \(ednpoing) to \(type)", underlying: error)
    }
    
    static func noData(from ednpoing: String) -> APIError {
        APIError(description: "No data in response from \(ednpoing)")
    }
}
