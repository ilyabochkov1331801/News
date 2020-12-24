//
//  NewsAPIEndpoints.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import Foundation

struct NewsAPIEndpoint<Response: Convertable> {
    typealias Param = String

    private let scheme: String = "https"
    private let host: String = "newsapi.org"
    private let key: String = "cef8f33307dc4e08b14184c97aa3fa91"
    let path: String
    private let params: [Param: String]
    
    init(path: String, params: [Param: String]) {
        self.path = path
        var reauestParams = params
        reauestParams[.key] = key
        self.params = reauestParams
    }
    
    func asRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        components.queryItems = params.compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        return components.url.flatMap { URLRequest(url: $0) }
    }
}

extension NewsAPIEndpoint {
    static func allNews(by keyWord: String) -> NewsAPIEndpoint<NewsArticlesAPI> {
        NewsAPIEndpoint<NewsArticlesAPI>(path: "/v2/everything", params: [.keyWord: keyWord])
    }
}

extension NewsAPIEndpoint.Param {
    static let keyWord = "q"
    static let key = "apiKey"
}
