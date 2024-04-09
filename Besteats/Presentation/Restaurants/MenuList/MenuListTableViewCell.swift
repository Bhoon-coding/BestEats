//
//  FoodDetailTableViewCell.swift
//  Besteats
//
//  Created by BH on 2022/03/17.
//

import UIKit

final class MenuListTableViewCell: UITableViewCell {
    
    // MARK: - Enums
    
    private enum MenuListCell {
        static let identifier: String = "MenuListTableViewCell"
    }
    
    // MARK: Properties
    
    static let identifier = MenuListCell.identifier
    
    private var selectedFavorite = false
    
    lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.bold, size: 20)
        label.textColor = .systemOrange
        label.numberOfLines = 2
        return label
    }()
    
    lazy var oneLinerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.bold, size: 14)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Image.star), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - Extensions

extension MenuListTableViewCell {
    
    private func configureCell() {
        contentView.addSubview(menuLabel)
        contentView.addSubview(oneLinerLabel)
        contentView.addSubview(favoriteButton)
        
        menuLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(30)
            $0.width.equalTo(200)
            $0.height.equalTo(48)
        }
        
        oneLinerLabel.snp.makeConstraints {
            $0.leading.equalTo(menuLabel)
            $0.top.equalTo(menuLabel.snp.bottom).offset(30)
            $0.width.equalTo(200)
            $0.height.equalTo(32)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.top.equalTo(menuLabel.snp.top)
            $0.trailing.equalToSuperview().inset(30)
            $0.size.equalTo(26)
        }
    }
}
