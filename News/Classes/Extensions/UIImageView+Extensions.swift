//
//  UIImageView+Extensions.swift
//  News
//
//  Created by Alena Niastsiorkina on 26.12.20.
//

import UIKit

extension UIImageView {
    func setContent(of url: URL) {
        ImageDownloader.shared.loadImage(with: url) {
            switch $0 {
            case .success(let image):
                self.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
}
