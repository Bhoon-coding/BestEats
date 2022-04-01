//
//  FoodDetailTableViewCell.swift
//  Besteats
//
//  Created by BH on 2022/03/17.
//

import UIKit

class MenuListTableViewCell: UITableViewCell {
    static let identifier = "MenuListTableViewCell"
    
    var selectedFavorite = false
    
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
        button.backgroundColor = .orange
        button.setImage(UIImage(named: "star"), for: .normal)
        button.addTarget(self, action: #selector(tappedFavorite(button:)), for: .touchUpInside)
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
        contentView.addSubview(favoriteButton)
        
        menuLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(30)
        }
        
        oneLinerLabel.snp.makeConstraints {
            $0.leading.equalTo(menuLabel)
            $0.top.equalTo(menuLabel.snp.bottom).offset(30)
        }
        
        
        favoriteButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(30)
            $0.size.equalTo(28)
        }
    }
    
      @objc func tappedFavorite(button: UIButton) {
        selectedFavorite = !selectedFavorite
          
        selectedFavorite
          ? favoriteButton.setImage(UIImage(named: "starFill"), for: .normal)
          : favoriteButton.setImage(UIImage(named: "star"), for: .normal)
        
    }
    
}
