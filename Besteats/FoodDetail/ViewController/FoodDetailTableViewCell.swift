//
//  FoodDetailTableViewCell.swift
//  Besteats
//
//  Created by BH on 2022/03/17.
//

import UIKit

class FoodDetailTableViewCell: UITableViewCell {
    static let identifier = "FoodDetailTableViewCell"
    
    lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BM JUA_OTF", size: 30)
        return label
    }()
    
    lazy var oneLinerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BM JUA_OTF", size: 16)
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCell() {
        
        contentView.addSubview(menuLabel)
        contentView.addSubview(oneLinerLabel)
        contentView.addSubview(deleteButton)
        
        menuLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(30)
        }
        
        oneLinerLabel.snp.makeConstraints {
            $0.leading.equalTo(menuLabel)
            $0.top.equalTo(menuLabel.snp.bottom).offset(30)
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.top.equalToSuperview().inset(30)
            $0.size.equalTo(16)
        }
    }
    
}
