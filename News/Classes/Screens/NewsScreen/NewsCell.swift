//
//  NewsCell.swift
//  News
//
//  Created by Alena Niastsiorkina on 25.12.20.
//

import UIKit
import Kingfisher

final class NewsCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .activity
        imageView.alpha = 0.5
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .right
        return label
    }()
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var previewImageURL: URL? {
        didSet {
            if let url = previewImageURL {
                previewImageView.kf.setImage(with: url,
                                             placeholder: UIImage(named: "imagePlaceholder"),
                                             options: [.processor(BlurImageProcessor(blurRadius: 5))])
            } else {
                previewImageView.image = UIImage(named: "imagePlaceholder")
            }
        }
    }
    
    var date: Date? {
        didSet {
            if let date = date {
                dateLabel.text = DateFormatters.viewDateFormatter.string(from: date)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        previewImageView.kf.cancelDownloadTask()
    }
}

private extension NewsCell {
    func customInit() {
        arrangeView()
        setupView()
    }
    
    func arrangeView() {
        contentView.addSubview(previewImageView)
        previewImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    func setupView() {
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .gray
    }
}
