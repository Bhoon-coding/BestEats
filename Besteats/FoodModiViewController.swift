//
//  FoodModiViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/30.
//

import UIKit
import SnapKit

class FoodModiViewController: UIViewController {
    
    lazy var restaurantNameWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    lazy var restaurantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "맛집명:"
        return label
    }()
    
    lazy var restaurantNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "맛집 이름을 입력해주세요."
        textField.paddingLeft()
        return textField
    }()
    
    lazy var oneLinerWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        return view
    }()
    
    lazy var oneLinerLabel: UILabel = {
        let label = UILabel()
        label.text = "한줄평:"
        return label
    }()
    
    lazy var oneLinerTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "맛있게 먹는 꿀팁을 작성해주세요."
        textField.paddingLeft()
        return textField
    }()
    
    lazy var cautionWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        return view
    }()
    
    lazy var cautionLabel: UILabel = {
        let label = UILabel()
        label.text = "주의점:"
        return label
    }()
    
    lazy var cautionTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "다음엔 이거 빼고!!"
        textField.paddingLeft()
        return textField
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        setUpUI()
        
    }
    
    private func setUpUI() {
        // MARK: addSubView
        view.addSubview(restaurantNameWrapper)
        restaurantNameWrapper.addSubview(restaurantNameLabel)
        restaurantNameWrapper.addSubview(restaurantNameTextField)
        view.addSubview(oneLinerWrapper)
        oneLinerWrapper.addSubview(oneLinerLabel)
        oneLinerWrapper.addSubview(oneLinerTextField)
        
        restaurantNameWrapper.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(50)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(100)
        }
        
        restaurantNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(40)

        }

        restaurantNameTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(restaurantNameLabel.snp.trailing).inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(restaurantNameLabel)
            
        }
        
        oneLinerWrapper.snp.makeConstraints {
            $0.top.equalTo(restaurantNameWrapper.snp.bottom).offset(24)
            $0.leading.equalTo(restaurantNameWrapper.snp.leading)
            $0.trailing.equalTo(restaurantNameWrapper.snp.trailing)
            $0.height.equalTo(restaurantNameWrapper.snp.height)
        }
        
        oneLinerLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        oneLinerTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(restaurantNameLabel.snp.trailing).inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(restaurantNameLabel)
        }
        
        
        
        
    }
    
}

extension UITextField {
    func paddingLeft() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

#if DEBUG

import SwiftUI
@available(iOS 13.0, *)

// UIViewControllerRepresentable을 채택
struct FoodModiViewControllerRepresentable: UIViewControllerRepresentable {
    // update
    // _ uiViewController: UIViewController로 지정
    func updateUIViewController(_ uiViewController: UIViewController , context: Context) {
        
    }
    // makeui
    func makeUIViewController(context: Context) -> UIViewController {
    // Preview를 보고자 하는 Viewcontroller 이름
    // e.g.)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        return storyboard.instantiateViewController(withIdentifier: "FoodModiViewController") as! FoodModiViewController
//
        return FoodModiViewController()
    }
}

struct FoodModiViewController_Previews: PreviewProvider {
    
    @available(iOS 13.0, *)
    static var previews: some View {
        // UIViewControllerRepresentable에 지정된 이름.
        FoodModiViewControllerRepresentable()

// 테스트 해보고자 하는 기기
            .previewDevice("iPhone 12")
    }
}
#endif
