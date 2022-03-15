//
//  MenuAddViewController.swift
//  Besteats
//
//  Created by BH on 2022/03/15.
//

import UIKit

import SnapKit
import Toast_Swift

class MenuAddViewController: UIViewController {
    
    // MARK: Properties
    
    lazy var wholeView: UIView = {
        let view = UIView()
//        view.backgroundColor = .brown
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var restaurantLabel: UILabel = {
        let label = UILabel()
        label.text = "맛집명"
        label.font = UIFont(name: "BM JUA_OTF", size: 24)
        return label
    }()
    
    lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.text = "메뉴명"
        label.font = UIFont(name: "BM JUA_OTF", size: 24)
        return label
    }()
    
    lazy var menuTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "메뉴를 적어주세요."
        textField.font = UIFont(name: "BM JUA_OTF", size: 16)
        textField.backgroundColor = .white
        textField.paddingLeft()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var oneLinerLabel: UILabel = {
        let label = UILabel()
        label.text = "한줄팁"
        label.font = UIFont(name: "BM JUA_OTF", size: 24)
        return label
    }()
    
    lazy var oneLinerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "한줄팁을 적어주세요."
        textField.font = UIFont(name: "BM JUA_OTF", size: 16)
        textField.backgroundColor = .white
        textField.paddingLeft()
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = "내평가"
        label.font = UIFont(name: "BM JUA_OTF", size: 24)
        return label
    }()

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    
    }
    
    // MARK: Methods
    
    private func setUpUI() {
        
        view.addSubview(wholeView)
        wholeView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(24)
        }
        
        wholeView.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.size.equalTo(20)
        }
        
        wholeView.addSubview(restaurantLabel)
        restaurantLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        wholeView.addSubview(menuLabel)
        menuLabel.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.bottom).offset(50)
            $0.leading.equalToSuperview()
        }
        
        wholeView.addSubview(menuTextField)
        menuTextField.snp.makeConstraints {
            $0.top.equalTo(menuLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview()
            $0.width.equalTo(250)
            $0.height.equalTo(44)
        }
        
        wholeView.addSubview(oneLinerLabel)
        oneLinerLabel.snp.makeConstraints {
            $0.top.equalTo(menuTextField.snp.bottom).offset(50)
            $0.leading.equalToSuperview()
        }
        
        wholeView.addSubview(oneLinerTextField)
        oneLinerTextField.snp.makeConstraints {
            $0.top.equalTo(oneLinerLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview()
            $0.width.equalTo(250)
            $0.height.equalTo(44)
        }
        
        wholeView.addSubview(typeLabel)
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(oneLinerTextField.snp.bottom).offset(50)
            $0.leading.equalToSuperview()
        }
    }
    
    // MARK: @objc
    
    @objc func closeTapped() {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: Extension

#if DEBUG

import SwiftUI
@available(iOS 13.0, *)

// UIViewControllerRepresentable을 채택
struct MenuAddViewControllerRepresentable: UIViewControllerRepresentable {
    // update
    // _ uiViewController: UIViewController로 지정
    func updateUIViewController(_ uiViewController: UIViewController , context: Context) {
        
    }
    // makeui
    func makeUIViewController(context: Context) -> UIViewController {
    // Preview를 보고자 하는 Viewcontroller 이름
    // e.g.)
        let menuAddVC = MenuAddViewController()
        return menuAddVC
        
    }
}

struct MenuAddViewController_Previews: PreviewProvider {
    
    @available(iOS 13.0, *)
    static var previews: some View {
        // UIViewControllerRepresentable에 지정된 이름.
        MenuAddViewControllerRepresentable()

// 테스트 해보고자 하는 기기
            .previewDevice("iPhone 12")
    }
}
#endif
