//
//  AppDelegate.swift
//  News
//
//  Created by Ilya Bochkov on 12/24/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: Router?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureAppearence()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        router = Router()
        router?.start(at: window)
        
        return true
    }
}

private extension AppDelegate {
    func configureAppearence() {
        UINavigationBar.appearance().prefersLargeTitles = true
    }
}
