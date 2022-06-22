//
//  FoodTypeCollectionViewCell.swift
//  Besteats
//
//  Created by BH on 2022/06/22.
//

import UIKit

class FoodTypeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Enums
    
    
    
    
    // MARK: - Properties
    
    static let identifier = "FoodTypeCollectionViewCell"
    
    
    lazy var foodTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemOrange
        imageView.image = #imageLiteral(resourceName: "AppLogo")
        return imageView
    }()
    
    lazy var foodTypeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension FoodTypeCollectionViewCell {
    func configureCell() {
        
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 8
        [foodTypeImageView,
         foodTypeLabel]
            .forEach { contentView.addSubview($0) }
        
        foodTypeImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
        }
        
        foodTypeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(foodTypeImageView.snp.bottom).offset(8)
        }
    }
}
