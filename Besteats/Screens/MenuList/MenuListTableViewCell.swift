//
//  FoodDetailTableViewCell.swift
//  Besteats
//
//  Created by BH on 2022/03/17.
//

import UIKit

class MenuListTableViewCell: UITableViewCell {
    
    // MARK: Properties
    static let identifier = "MenuListTableViewCell"
    
    var selectedFavorite = false
    
    lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansBold", size: 20)
        label.textColor = .systemOrange
        label.numberOfLines = 2
        return label
    }()
    
    lazy var oneLinerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansBold", size: 14)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "star"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Methods
    func configure() {
        
    }
    
    private func setUpCell() {
        
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
