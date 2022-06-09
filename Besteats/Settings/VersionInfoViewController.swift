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
        label.text = "현재 버전: "
        label.textColor = .gray
        return label
    }()
    
    private lazy var latestVersionLabel: UILabel = {
        let label = UILabel()
        label.text = "최신 버전: "
        return label
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let currentVersion = currentVersion {
//            currentVersionLabel.text = "현재 버전: \(currentVersion)"
//        }
        let test = isUpdateAvailable()
        print(test)
        
        configureUI()
    }
    
    // MARK: - Methods
    
    private func isUpdateAvailable() -> Bool {
        guard let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
              let url = URL(string: "http://itunes.apple.com/lookup?bundleId=com.bhooncoding.Besteats"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any],
              let results = json["results"] as? [[String: Any]],
              results.count > 0,
              let appStoreVersion = results[0]["version"] as? String
                
        else { return false }
        print("data: \(data)")
        print("json: \(json)")
        print("results: \(results)")
        
        if !(currentVersion == appStoreVersion) {
            return true
        } else {
            return false
        }
        
    }
    
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
        
        view.addSubview(latestVersionLabel)
        latestVersionLabel.snp.makeConstraints {
            $0.bottom.equalTo(currentVersionLabel).offset(24)
            $0.centerX.equalToSuperview()
        }
    }
    
    

}
