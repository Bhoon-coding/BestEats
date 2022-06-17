//
//  VersionInfoViewController.swift
//  Besteats
//
//  Created by BH on 2022/06/07.
//

import UIKit

class VersionInfoViewController: UIViewController {
    
    // MARK: - Enums
    
    
    // MARK: - Properties
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppLogo")
        return imageView
    }()
    
    private lazy var currentVersionLabel: UILabel = {
        let label = UILabel()
        label.smallLabel(label: label)
        return label
    }()
    
    private lazy var appStoreVersionLabel: UILabel = {
        let label = UILabel()
        label.smallLabel(label: label)
        label.textColor = .gray
        return label
    }()
    
    lazy var updateButton: UIButton = {
        let button = UIButton()
        button.setTitle("업데이트 하기", for: .normal)
        button.mediumButton(button: button)
        button.backgroundColor = .systemOrange
        button.addTarget(self,
                         action: #selector(openAppStore),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isUpdateNeeded()
        configureUI()
    }
    
    // MARK: - Methods
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(300)
            $0.width.height.equalTo(120)
        }
        
        view.addSubview(currentVersionLabel)
        currentVersionLabel.snp.makeConstraints {
            $0.bottom.equalTo(logoImageView).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(appStoreVersionLabel)
        appStoreVersionLabel.snp.makeConstraints {
            $0.bottom.equalTo(currentVersionLabel).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(updateButton)
        updateButton.snp.makeConstraints {
            $0.top.equalTo(appStoreVersionLabel).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(42)
        }
    }
    
    private func isUpdateNeeded() -> () {
        guard let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
              let url = URL(string: "http://itunes.apple.com/lookup?bundleId=com.bhooncoding.Besteats"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any],
              let results = json["results"] as? [[String: Any]],
              results.count > 0,
              let appStoreVersion = results[0]["version"] as? String
                
        else {
            print("<VersionInfoVC> - 앱 버전을 찾을 수 없습니다.")
            return
        }
        currentVersionLabel.text = "현재 버전: \(currentVersion)"
        appStoreVersionLabel.text = "최신 버전: \(appStoreVersion)"
        
        if !(currentVersion == appStoreVersion) {
            updateButton.isEnabled = true
            updateButton.backgroundColor = .systemOrange
            updateButton.setTitle("업데이트 하기", for: .normal)
        } else {
            updateButton.isEnabled = false
            updateButton.backgroundColor = .lightGray
            updateButton.setTitle("최신버전 입니다.", for: .normal)
        }
    }
    
    @objc func openAppStore() {
        let url = "itms-apps://itunes.apple.com/app/" + Constants.appId
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url,
                                          options: [:],
                                          completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
}
