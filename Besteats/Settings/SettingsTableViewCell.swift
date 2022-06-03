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
    
    lazy var notificationSwitch: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tappedNotification), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
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
    
    // MARK: - @objc
    
    @objc func tappedNotification() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)

    }
}
