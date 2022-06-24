//
//  FoodImageViewController.swift
//  Besteats
//
//  Created by BH on 2022/06/24.
//

import UIKit

import SnapKit

final class FoodImageViewController: UIViewController {
    
    // MARK: - Enums
    
    private enum FoodImageVCString {
        
        
    }
    
    // MARK: - Properties
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Image.close),
                        for: .normal)
        button.addTarget(self,
                         action: #selector(dismissVC),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "hamburger")
        
        return imageView
    }()
    
    private lazy var bottomButtonWrapper : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [prevButton,
                                                      nextButton])
        stackView.distribution = .fillEqually
//        stackView.backgroundColor = .systemOrange
        return stackView
    }()
    
    private lazy var prevButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Image.arrowLeft),
                        for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .brown
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Image.arrowRight),
                        for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .cyan
        return button
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextButton.setPreferredSymbolConfiguration(.init(pointSize: 30, weight: .regular, scale: .default) , forImageIn: .normal)
    }
    
    // MARK: - Methods
    
    
    // MARK: - @objc
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
}

// MARK: - Extensions

extension FoodImageViewController {
    
    private func configureUI() {
        view.backgroundColor = .black
        
        [closeButton,
         foodImageView,
         bottomButtonWrapper
        ]
            .forEach { view.addSubview($0) }
        
        closeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(16)
        }
        
        foodImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(80)
        }
        
        bottomButtonWrapper.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.top.equalTo(foodImageView.snp.bottom)
        }
        
        prevButton.snp.makeConstraints {
            $0.width.equalTo(24)
        }
        nextButton.snp.makeConstraints {
            $0.width.equalTo(24)
        }
        
        
    }

}

// 전처리
#if DEBUG

import SwiftUI
@available(iOS 13.0, *)

// UIViewControllerRepresentable을 채택
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    // update
    // _ uiViewController: UIViewController로 지정
    func updateUIViewController(_ uiViewController: UIViewController , context: Context) {
        
    }
    // makeui
    func makeUIViewController(context: Context) -> UIViewController {
    // Preview를 보고자 하는 Viewcontroller 이름
    // e.g.)
        return FoodImageViewController()
    }
}

struct ViewController_Previews: PreviewProvider {
    
    @available(iOS 13.0, *)
    static var previews: some View {
        // UIViewControllerRepresentable에 지정된 이름.
        ViewControllerRepresentable()

// 테스트 해보고자 하는 기기
            .previewDevice("iPhone 11")
    }
}
#endif
