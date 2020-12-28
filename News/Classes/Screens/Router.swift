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
        navigationController.pushViewController(screen, animated: true)
    }
}

extension Router: DependencyInjector { }

private extension Router {
    func registerServices() {
        register(DataManagersAssembly.makeNewsAPIDataManager())
    }
}
