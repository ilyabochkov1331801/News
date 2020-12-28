//
//  NewsController.swift
//  News
//
//  Created by Alena Niastsiorkina on 25.12.20.
//

import UIKit

final class NewsController: Controller<NewsView> {
    private let newsSearchBarController: UISearchController = {
        let searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.searchBar.placeholder = "Apple"
        return searchBarController
    }()
    
    private let newsService: NewsService
    private var news: NewsArticles? {
        didSet { contentView.reloadNews() }
    }
    
    var openDetailsTransition: ((Article, String) -> Void)?
    
    init(newsService: NewsService) {
        self.newsService = newsService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        title = "News"
        
        newsSearchBarController.obscuresBackgroundDuringPresentation = false
        newsSearchBarController.searchBar.delegate = self
        navigationItem.searchController = newsSearchBarController
        
        contentView.setNewsCollectionView(delegate: self, dataSource: self)
    }
}

extension NewsController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        contentView.scrollToTop()
        searchBar.placeholder = searchBar.text
        
        contentView.showActivityIndicator()
        newsService.loadNews(by: text) { [weak self] in
            self?.contentView.hideActivityIndicator()
            switch $0 {
            case .success(let news):
                self?.news = news
            case .failure(let error):
                print(error.fullUserDescription())
            }
        }
    }
}

extension NewsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let article = news?.articles[indexPath.row] {
            openDetailsTransition?(article, newsSearchBarController.searchBar.placeholder ?? "News")
        }
    }
}

extension NewsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        news?.articles.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseIdentifier, for: indexPath) as? NewsCell else {
            return UICollectionViewCell()
        }
        
        cell.title = news?.articles[indexPath.row].title
        cell.previewImageURL = news?.articles[indexPath.row].imageURL
        cell.date = news?.articles[indexPath.row].date
        return cell
    }
}
