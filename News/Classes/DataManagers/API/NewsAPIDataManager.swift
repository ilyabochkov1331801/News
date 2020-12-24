//
//  NewsAPIDataManager.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

final class NewsAPIDataManager {
    private let session = URLSession.shared
    
    func executeRequest<Response>(with endpoint: NewsAPIEndpoint<Response>,
                                  completion: @escaping (Result<Response.Target, DataManagerError>) -> Void) {
        
        let wrapErrorClosure: (APIError) -> DataManagerError = {
            .newsAPIError(error: $0)
        }
        
        guard let request = endpoint.asRequest() else {
            completion(.failure(wrapErrorClosure(.buildRequestError(from: endpoint.path))))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(wrapErrorClosure(.taskError(error: error))))
                return
            }
            
            guard let code = (response as? HTTPURLResponse)?.statusCode else {
                completion(.failure(wrapErrorClosure(.invalidResponse(with: nil))))
                return
            }
            
            guard (200..<300).contains(code) else {
                completion(.failure(wrapErrorClosure(.invalidResponse(with: code))))
                return
            }
            
            guard let data = data else {
                completion(.failure(wrapErrorClosure(.noData(from: endpoint.path))))
                return
            }
            
            do {
                let appResponse = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(appResponse.convert()))
            } catch {
                completion(.failure(wrapErrorClosure(.decodeError(from: endpoint.path,
                                                                  type: String(describing: Response.self),
                                                                  error: error))))
            }
        }.resume()
    }
}
