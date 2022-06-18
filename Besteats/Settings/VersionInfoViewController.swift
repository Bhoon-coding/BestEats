//
//  VersionInfoViewController.swift
//  Besteats
//
//  Created by BH on 2022/06/07.
//

import UIKit

class VersionInfoViewController: UIViewController {
    
    // MARK: - Enums
    private enum VersionInfoString {
        
        enum Image {
            static let logo = "AppLogo"
        }
        enum Button {
            static let updateTitle = "업데이트 하기"
            static let latestTitle = "최신버전 입니다."
        }
        enum Label {
            static let currentVersion = "현재 버전"
            static let latestVersion = "최신 버전"
        }
        enum Url {
            static let app = "http://itunes.apple.com/lookup?bundleId=com.bhooncoding.Besteats"
            static let appStore = "itms-apps://itunes.apple.com/app/"
        }
    }
    
    // MARK: - Properties
    
    private lazy var wholeWrapper: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: VersionInfoString.Image.logo)
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
        button.setTitle(VersionInfoString.Button.updateTitle, for: .normal)
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
    
    private func isUpdateNeeded() -> () {
        guard let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
              let url = URL(string: VersionInfoString.Url.app),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any],
              let results = json["results"] as? [[String: Any]],
              results.count > 0,
              let appStoreVersion = results[0]["version"] as? String
                
        else {
            print("<VersionInfoVC> - 앱 버전을 찾을 수 없습니다.")
            return
        }
        currentVersionLabel.text = VersionInfoString.Label.currentVersion + currentVersion
        appStoreVersionLabel.text = VersionInfoString.Label.latestVersion +  appStoreVersion
        
        if !(currentVersion == appStoreVersion) {
            updateButton.isEnabled = true
            updateButton.backgroundColor = .systemOrange
            updateButton.setTitle(VersionInfoString.Button.updateTitle, for: .normal)
        } else {
            updateButton.isEnabled = false
            updateButton.backgroundColor = .lightGray
            updateButton.setTitle(VersionInfoString.Button.latestTitle, for: .normal)
        }
    }
    
    @objc func openAppStore() {
        let url = VersionInfoString.Url.app + Constants.appId
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

// MARK: - Extensions

extension VersionInfoViewController {
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(wholeWrapper)
        wholeWrapper.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(240)
        }
        
        wholeWrapper.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(120)
        }
        
        wholeWrapper.addSubview(currentVersionLabel)
        currentVersionLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        wholeWrapper.addSubview(appStoreVersionLabel)
        appStoreVersionLabel.snp.makeConstraints {
            $0.top.equalTo(currentVersionLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        wholeWrapper.addSubview(updateButton)
        updateButton.snp.makeConstraints {
            $0.top.equalTo(appStoreVersionLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(42)
        }
    }
}
