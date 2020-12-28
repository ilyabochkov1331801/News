//
//  Router.swift
//  News
//
//  Created by Alena Niastsiorkina on 25.12.20.
//

import UIKit

final class Router {
    var container: [Resolvable] = []
    private let navigationController: UINavigationController
    
    init() {
        navigationController = UINavigationController()

        registerServices()
    }
    
    func start(at window: UIWindow?) {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        showNewsScreen()
    }
    
    func showNewsScreen() {
        let screen = ScreensAssembly.makeNewsScreen(injector: self)
        
        screen.openDetailsTransition = { [weak self] in
            self?.showDetailsScreen(with: $0, title: $1)
        }
        
        navigationController.pushViewController(screen, animated: true)
    }
    
    func showDetailsScreen(with article: Article, title: String) {
        let screen = ScreensAssembly.makeDetailsScreen(article: article, title: title)
        
        screen.openLink = {
            UIApplication.shared.openLinkIfCan($0)
        }
        
        screen.closeTransition = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(screen, animated: true)
    }
}

extension Router: DependencyInjector { }

private extension Router {
    func registerServices() {
        register(DataManagersAssembly.makeNewsAPIDataManager())
    }
}
