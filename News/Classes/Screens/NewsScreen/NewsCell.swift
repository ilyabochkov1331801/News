//
//  NewsCell.swift
//  News
//
//  Created by Alena Niastsiorkina on 25.12.20.
//

import UIKit

final class NewsCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var imageURL: URL? {
        didSet {
            if let url = imageURL {
                imageView.setContent(of: url)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        customInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NewsCell {
    func customInit() {
        arrangeView()
        setupView()
    }
    
    func arrangeView() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(20)
        }
    }
    
    func setupView() {
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .blue
    }
}
