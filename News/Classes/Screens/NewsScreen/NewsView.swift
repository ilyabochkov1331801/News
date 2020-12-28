//
//  NewsView.swift
//  News
//
//  Created by Alena Niastsiorkina on 25.12.20.
//

import SnapKit
import UIKit

final class NewsView: View {
    private let newsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = Constants.newsCellSize
        flowLayout.minimumLineSpacing = Constants.cellsSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseIdentifier)
        return collectionView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.isHidden = true
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    override func arrangeView() {
        addSubview(newsCollectionView)
        newsCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setupView() {
        backgroundColor = .white
    }
    
    func setNewsCollectionView(delegate: UICollectionViewDelegate?, dataSource: UICollectionViewDataSource) {
        newsCollectionView.delegate = delegate
        newsCollectionView.dataSource = dataSource
    }
    
    func reloadNews() {
        newsCollectionView.reloadData()
    }
    
    func scrollToTop() {
        newsCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredVertically, animated: true)
    }
    
    func showActivityIndicator() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
}

private extension NewsView  {
    enum Constants {
        static let newsCellSize: CGSize = {
            let ratio: CGFloat = 0.9
            let width = UIScreen.main.bounds.width - 30
            return CGSize(width: width, height: width  * ratio)
        }()
        
        static let cellsSpacing: CGFloat = 30
    }
}
