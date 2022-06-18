//
//  SettingsTableViewController.swift
//  Besteats
//
//  Created by BH on 2022/06/03.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    // MARK: - Enums
    
    private enum Settings {
        static let title = "설정"
        static let section: [String] = ["알림설정", "지원"]
        
        enum List {
            static let notification: [String] = ["푸시 알림 설정"]
            static let info: [String] = ["버전정보"]
        }
    }
    
    // MARK: - Properties
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
    }
    
    // MARK: - Methods
    
    private func configureNavBar() {
        title = Settings.title
        
        let backBarButtonItem = UIBarButtonItem(title: "",
                                                style: .plain,
                                                target: self, action: nil)
        
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }

    private func configureTableView() {
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.rowHeight = 48
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Settings.section[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Settings.section.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return Settings.List.notification.count
        } else if section == 1 {
            return Settings.List.info.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else { return SettingsTableViewCell() }

        cell.configureCell()
        
        if indexPath.section == 0 {
            cell.cellLabel.text = Settings.List.notification[indexPath.row]
        } else if indexPath.section == 1{
            cell.cellLabel.text = Settings.List.info[indexPath.row]
        } 

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            default:
                print("알림설정 section: other rows")
            }
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                navigationController?.pushViewController(VersionInfoViewController(), animated: true)
            default:
                print("지원 section: other rows")
            }
        }
    }
}
