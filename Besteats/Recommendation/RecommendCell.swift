//
//  RecommendCell.swift
//  Besteats
//
//  Created by BH on 2022/10/11.
//

import UIKit

import SnapKit

final class RecommendCell: UICollectionViewCell {
    
    private lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Style.foodImage
        return imageView
    }()
    
    private lazy var foodTypeLabel: UILabel = {
        let label = UILabel()
        label.text = Text.foodType
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureConstraints()
    }
    
    
}

// MARK: - Configure UI

extension RecommendCell {
    
    private func configureUI() {
        
        [foodImageView, foodTypeLabel].forEach { contentView.addSubview($0) }
        
    }
    
}

// MARK: - Configure Constraints

extension RecommendCell {
    
    private func configureConstraints() {
        foodImageView.snp.makeConstraints {
            $0.top.trailing.bottom.leading.equalToSuperview()
        }
        
        foodTypeLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(8)
        }
    }
    
}

// MARK: - NameSpaces

extension RecommendCell {
    
    private enum Text {
        
        static let foodType: String = "한식"
    }
    
    private enum Style {
        static let foodImage: UIImage? = .init(named: "KoreanFood")
    }
    
}

