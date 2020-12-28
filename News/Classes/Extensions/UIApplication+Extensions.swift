//
//  UIApplication+Extensions.swift
//  News
//
//  Created by Ilya Bochkov on 12/28/20.
//

import UIKit.UIApplication

public extension UIApplication {
    @discardableResult
    func openLinkIfCan(_ link: URL) -> Bool {
        guard UIApplication.shared.canOpenURL(link) else { return false }
        UIApplication.shared.open(link, options: [:], completionHandler: nil)
        return true
    }
}
