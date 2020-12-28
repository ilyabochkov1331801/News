//
//  ServicesAssembly.swift
//  News
//
//  Created by Alena Niastsiorkina on 25.12.20.
//

import Foundation

final class ServicesAssembly {
    static func makeNewsService(injector: DependencyInjector) -> NewsService {
        NewsService(newsAPIDataManager: injector.resolve(NewsAPIDataManager.self))
    }
}
