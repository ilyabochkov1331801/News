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
        
        let wrappedCompletion = wrapCompletion(completion: completion)
        
        guard let request = endpoint.asRequest() else {
            wrappedCompletion(.failure(NetworkError.buildRequestError(from: endpoint.path)))
            return
        }
                
        session.dataTask(with: request) { data, response, error in
            
            let decodeDataClosure: (Data) -> Void = {
                do {
                    let appResponse = try JSONDecoder().decode(Response.self, from: $0)
                    wrappedCompletion(.success(appResponse.convert()))
                } catch {
                    wrappedCompletion(.failure(NetworkError.decodeError(from: endpoint.path,
                                                                        type: String(describing: Response.self),
                                                                        error: error)))
                }
            }
            
            switch URLSession.validate(data, response, error) {
            case .success(let data):
                decodeDataClosure(data)
            case .failure(let error):
                wrappedCompletion(.failure(error))
            }
        }.resume()
    }
}

extension NewsAPIDataManager: Resolvable { }

private extension NewsAPIDataManager {
    func wrapCompletion<Response>(completion: @escaping (Result<Response, DataManagerError>) -> Void) -> (Result<Response, AppError>) -> Void {
        return { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(.newsAPIError(error: error)))
                }
            }
        }
    }
}
