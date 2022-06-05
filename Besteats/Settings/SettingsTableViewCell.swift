//
//  SettingsTableViewCell.swift
//  Besteats
//
//  Created by BH on 2022/06/03.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    // MARK: - Enums
    
    private enum Settings {
        static let identifier: String = "SettingsTableViewCell"
        
        enum Label {
            static let notification = "알림"
        }
        
        enum Image {
            static let chevronRight = "chevron.right"
        }
    }
    
    // MARK: - Properties
    
    static let identifier = Settings.identifier
    
    lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.text = Settings.Label.notification
        return label
    }()
    
    lazy var notificationSwitch: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Settings.Image.chevronRight), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        contentView.addSubview(notificationLabel)
        contentView.addSubview(notificationSwitch)
        
        notificationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        notificationSwitch.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
}
