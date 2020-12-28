//
//  NetworkError.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

final class NetworkError: AppError {
    static func taskError(error: Error) -> NetworkError {
        NetworkError(description: "Data task finished with error", underlying: error)
    }
    
    static func buildRequestError(from endpoint: String) -> NetworkError {
        NetworkError(description: "Can't build request from endpoint - \(endpoint)")
    }
    
    static func invalidResponse(with code: Int?) -> NetworkError {
        NetworkError(description: "Invalid response code - \(String(describing: code))")
    }
    
    static func decodeError(from endpoint: String, type: String, error: Error) -> NetworkError {
        NetworkError(description: "Can't decode response from \(endpoint) to \(type)", underlying: error)
    }
    
    static func noData(from url: URL?) -> NetworkError {
        NetworkError(description: "No data in response from " + (url?.absoluteString ?? "nil"))
    }
}
