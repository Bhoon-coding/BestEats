//
//  MenuDetailViewController.swift
//  Besteats
//
//  Created by BH on 2022/03/28.
//

import UIKit

import SnapKit

class MenuDetailViewController: UIViewController {

    // MARK: Properties

    lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 준비중 입니다. 🍖"
        label.mediumLabel(label: label)
        return label
    }()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    // MARK: Methods
    private func setUpUI() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(noticeLabel)
        
        noticeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
