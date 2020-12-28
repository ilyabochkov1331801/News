//
//  URLSession+Extensions.swift
//  News
//
//  Created by Alena Niastsiorkina on 26.12.20.
//

import Foundation

extension URLSession {
    static func validate(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<Data, NetworkError> {
        if let error = error {
            return .failure(NetworkError.taskError(error: error))
        }
            
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            return .failure(NetworkError.invalidResponse(with: nil))
        }
            
        guard (200..<300).contains(code) else {
            return .failure(NetworkError.invalidResponse(with: code))
        }
            
        guard let data = data else {
            return .failure(NetworkError.noData(from: response?.url))
        }
        
        return .success(data)
    }
}
