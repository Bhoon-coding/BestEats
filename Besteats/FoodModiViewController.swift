//
//  FoodModiViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/30.
//

import UIKit
import SnapKit

class FoodModiViewController: UIViewController {
    
    lazy var restaurantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "맛집명"
        return label
    }()
    
    lazy var restaurantNameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        setupUI()
        
    }
    
    private func setupUI() {
        // MARK: addSubView
        view.addSubview(restaurantNameLabel)
        view.addSubview(restaurantNameTextField)
        
        restaurantNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().inset(40)
        }
        
        restaurantNameTextField.snp.makeConstraints {
            $0.leading.equalTo(restaurantNameLabel).offset(32)
            $0.top.equalTo(restaurantNameLabel)
            $0.width.equalTo(150)
            $0.height.equalTo(40)
            
        }
        
        
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "FoodModiViewController") as! FoodModiViewController
        
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
