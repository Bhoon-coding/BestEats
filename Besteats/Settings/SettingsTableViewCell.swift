//
//  SettingsTableViewCell.swift
//  Besteats
//
//  Created by BH on 2022/06/03.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    private enum Settings {
        static let identifier: String = "SettingsTableViewCell"
    }
    
    // MARK: - Properties
    
    static let identifier = Settings.identifier
    
    lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "알림"
        return label
    }()
    
    lazy var notificationToggle: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        contentView.addSubview(notificationLabel)
        contentView.addSubview(notificationToggle)
        
        notificationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        notificationToggle.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
