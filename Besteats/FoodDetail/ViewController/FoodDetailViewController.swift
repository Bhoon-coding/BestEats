//
//  FoodDetailViewController.swift
//  Besteats
//
//  Created by BH on 2022/02/28.
//

import UIKit

import SnapKit

class FoodDetailViewController: UIViewController {
    
    // MARK: Properties
    lazy var typeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeTypeButton, curiousTypeButton, warningTypeButton])
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.backgroundColor = .red
        return stackView
    }()
    
    lazy var likeTypeButton: UIButton = {
        let button = UIButton()
        button.setTitle("좋아요", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedLikeButton), for: .touchUpInside)
        return button
    }()
    
    lazy var curiousTypeButton: UIButton = {
        let button = UIButton()
        button.setTitle("먹어볼래요", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedCuriousButton), for: .touchUpInside)
        return button
    }()
    
    lazy var warningTypeButton: UIButton = {
        let button = UIButton()
        button.setTitle("별로에요", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedWarningButton), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .brown
        setUpUI()
        
    }
    
    // MARK: Methods
    
    private func setUpUI() {
        
        view.addSubview(typeStackView)
        typeStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.height.equalTo(44)
        }
        
        likeTypeButton.snp.makeConstraints {
            $0.width.equalTo(68)
        }
        
        curiousTypeButton.snp.makeConstraints {
            $0.width.equalTo(68)
        }
        
        warningTypeButton.snp.makeConstraints {
            $0.width.equalTo(68)
        }
        
    }
    
    // MARK: @objc
    
    @objc func tappedLikeButton() {
        likeTypeButton.backgroundColor = .systemRed
        likeTypeButton.setTitleColor(.white, for: .normal)
    }
    
    @objc func tappedCuriousButton() {
        curiousTypeButton.backgroundColor = .systemRed
        curiousTypeButton.setTitleColor(.white, for: .normal)
    }
    
    @objc func tappedWarningButton() {
        warningTypeButton.backgroundColor = .systemRed
        warningTypeButton.setTitleColor(.white, for: .normal)
    }
}

#if DEBUG

import SwiftUI
@available(iOS 13.0, *)

// UIViewControllerRepresentable을 채택
struct FoodDetailViewControllerRepresentable: UIViewControllerRepresentable {
    // update
    // _ uiViewController: UIViewController로 지정
    func updateUIViewController(_ uiViewController: UIViewController , context: Context) {
        
    }
    // makeui
    func makeUIViewController(context: Context) -> UIViewController {
    // Preview를 보고자 하는 Viewcontroller 이름
    // e.g.)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        return storyboard.instantiateViewController(withIdentifier: "FoodDetailViewController") as! FoodDetailViewController
//
        return FoodDetailViewController()
    }
}

struct FoodDetailViewController_Previews: PreviewProvider {
    
    @available(iOS 13.0, *)
    static var previews: some View {
        // UIViewControllerRepresentable에 지정된 이름.
        Group {
            FoodDetailViewControllerRepresentable()

    // 테스트 해보고자 하는 기기
                .previewDevice("iPhone 12")
            FoodDetailViewControllerRepresentable()
            
            // 테스트 해보고자 하는 기기
                .previewDevice("iPhone 12")
        }
    }
}
#endif
