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
    
    let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
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
        if let currentVersion = currentVersion {
            currentVersionLabel.text = "현재 버전: \(currentVersion)"
        }
        
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
        
        view.addSubview(latestVersionLabel)
        latestVersionLabel.snp.makeConstraints {
            $0.bottom.equalTo(currentVersionLabel).offset(24)
            $0.centerX.equalToSuperview()
        }
    }
    
    

}
