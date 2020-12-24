//
//  NewsService.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

final class NewsService {
    private let newsAPIDataManager: NewsAPIDataManager
    
    init(newsAPIDataManager: NewsAPIDataManager) {
        self.newsAPIDataManager = newsAPIDataManager
    }
    
    func loadNews(by keyWord: String, completion: @escaping (Result<NewsArticles, ServiceError>) -> Void) {
        newsAPIDataManager.executeRequest(with: .allNews(by: keyWord)) {
            switch $0 {
            case .success(let news):
                completion(.success(news))
            case .failure(let error):
                completion(.failure(.newsError(error: error)))
            }
        }
    }
}
