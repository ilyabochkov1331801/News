//
//  ImageDownloader.swift
//  News
//
//  Created by Alena Niastsiorkina on 26.12.20.
//

import Foundation
import UIKit

final class ImageDownloader {
    
    static let shared = ImageDownloader()
    
    private let urlSession: URLSession = {
        let configuration = URLSessionConfiguration()
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        
        return URLSession(configuration: configuration)
    }()
    
    func loadImage(with url: URL, complection: @escaping (Result<UIImage, DataManagerError>) -> Void) {
        
        let wrappedCompletion = wrapCompletion(completion: complection)
        
        urlSession.dataTask(with: url) { data, response, error in
            let decodeDataClosure: (Data) -> Void = {
                guard let image = UIImage(data: $0) else {
                    wrappedCompletion(.failure(AppError(description: "Can't make image from data from \(url.absoluteString)")))
                    return
                }
                
                wrappedCompletion(.success(image))
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

private extension ImageDownloader {
    func wrapCompletion(completion: @escaping (Result<UIImage, DataManagerError>) -> Void) -> (Result<UIImage, AppError>) -> Void {
        return { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(.imageDownloaderError(error: error)))
                }
            }
        }
    }
}
