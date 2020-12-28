//
//  ScreensAssembly.swift
//  News
//
//  Created by Alena Niastsiorkina on 25.12.20.
//

import Foundation

final class ScreensAssembly {
    static func makeNewsScreen(injector: DependencyInjector) -> NewsController {
        NewsController(newsService: ServicesAssembly.makeNewsService(injector: injector))
    }
}
