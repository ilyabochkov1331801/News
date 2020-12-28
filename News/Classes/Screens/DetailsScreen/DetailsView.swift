//
//  DetailsView.swift
//  News
//
//  Created by Alena Niastsiorkina on 26.12.20.
//

import UIKit

final class DetailsView: View {
    private let contentTextVeiw: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .activity
        imageView.image = UIImage(named: "imagePlaceholder")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let sourceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sorce", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private let containerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    var sourceButtonAction: (() -> Void)?
    var closeButtonAction: (() -> Void)?
    
    override func arrangeView() {
        
        addSubview(containerScrollView)
        containerScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerScrollView.addSubview(previewImageView)
        previewImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(self)
            $0.height.equalTo(UIScreen.main.bounds.width)
        }
        
        containerScrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(self).inset(20)
            $0.top.equalTo(previewImageView.snp.bottom).offset(20)
        }
        
        containerScrollView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(self).inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        containerScrollView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom)
            $0.trailing.leading.equalTo(self).inset(20)
        }
        
        containerScrollView.addSubview(contentTextVeiw)
        contentTextVeiw.snp.makeConstraints {
            $0.leading.trailing.equalTo(self).inset(20)
            $0.top.equalTo(authorLabel.snp.bottom).offset(20)
        }
        
        containerScrollView.addSubview(sourceButton)
        sourceButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(50)
            $0.top.equalTo(contentTextVeiw.snp.bottom).offset(20)
        }
        
        containerScrollView.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(50)
            $0.top.equalTo(sourceButton.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    override func setupView() {
        backgroundColor = .white
        sourceButton.addTarget(self, action: #selector(sourceButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [closeButton, sourceButton].forEach { $0.layer.cornerRadius = $0.bounds.height / 2 }
    }
    
    func set(article: Article) {
        if let previewURL = article.imageURL {
            previewImageView.kf.setImage(with: previewURL)
        }
        
        if let date = article.date {
            dateLabel.text = DateFormatters.viewDateFormatter.string(from: date)
        }
        
        sourceButton.isHidden = article.sourceURL == nil
        titleLabel.text = article.title
        authorLabel.text = article.author
        contentTextVeiw.text = article.content
    }
}

private extension DetailsView {
    @objc func sourceButtonTapped() {
        sourceButtonAction?()
    }
    
    @objc func closeButtonTapped() {
        closeButtonAction?()
    }
}
