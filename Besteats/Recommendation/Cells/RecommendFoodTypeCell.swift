//
//  RecommendCell.swift
//  Besteats
//
//  Created by BH on 2022/10/11.
//

import UIKit

import SnapKit

final class RecommendFoodTypeCell: UICollectionViewCell {
    
    private lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Style.cornerRadius
        return imageView
    }()
    
    private lazy var foodTypeLabel: UILabel = {
        let label = UILabel()
        label.text = Text.foodType
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: Style.boldFontSize)
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
    
    func setupCell(foodInfo: FoodInfo) {
        foodImageView.image = foodInfo.image
        foodTypeLabel.text = foodInfo.label
    }
    
    
}

// MARK: - Configure UI

extension RecommendFoodTypeCell {
    
    private func configureUI() {
        
        [foodImageView, foodTypeLabel].forEach { contentView.addSubview($0) }
        
    }
    
}

// MARK: - Configure Constraints

extension RecommendFoodTypeCell {
    
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

extension RecommendFoodTypeCell {
    
    private enum Text {
        static let foodType: String = ""
    }
    
    private enum Style {
        static let cornerRadius: CGFloat = 20
        static let boldFontSize: CGFloat = 32
        
    }
    
}

