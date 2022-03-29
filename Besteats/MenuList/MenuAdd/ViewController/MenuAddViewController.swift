//
//  MenuAddViewController.swift
//  Besteats
//
//  Created by BH on 2022/03/15.
//

import UIKit

import SnapKit
import Toast_Swift

class MenuAddViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    var selectedLike: Bool = false
    var selectedCurious: Bool = false
    var selectedWarning: Bool = false
    var type: String? = nil
    var selectedIndex: Int
    private var selectedRestaurant: Restaurants
    
    init(selectedRestaurant: Restaurants, selectedIndex: Int) {
        self.selectedRestaurant = selectedRestaurant
        self.selectedIndex = selectedIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var wholeView: UIView = {
        let view = UIView()
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
        label.text = "\(selectedRestaurant.restaurantName)"
        label.mediumLabel(label: label)
        return label
    }()
    
    lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.text = "메뉴명"
        label.mediumLabel(label: label)
        return label
    }()
    
    lazy var menuTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "메뉴를 적어주세요."
        textField.placeholderConvention(textField: textField)
        return textField
    }()
    
    lazy var oneLinerLabel: UILabel = {
        let label = UILabel()
        label.text = "한줄팁"
        label.mediumLabel(label: label)
        return label
    }()
    
    lazy var oneLinerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "한줄팁을 적어주세요."
        textField.placeholderConvention(textField: textField)
        return textField
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = "내평가"
        label.mediumLabel(label: label)
        return label
    }()
    
    lazy var typeView: UIView = {
        let view = UIView()
//        view.backgroundColor = .brown
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var typeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var typeLikeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "like"), for: .normal)
        button.addTarget(self, action: #selector(tappedLike(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var typeCuriousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "curious"), for: .normal)
        button.addTarget(self, action: #selector(tappedCurious(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var typeWarningButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "warning"), for: .normal)
        button.addTarget(self, action: #selector(tappedWarning(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("메뉴 추가", for: .normal)
        button.tintColor = .label
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        return button
    }()

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTextField.delegate = self
        oneLinerTextField.delegate = self

        setUpUI()
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Methods
    
    private func setUpUI() {
        
        view.backgroundColor = .white
        
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
            $0.leading.trailing.equalToSuperview()
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
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        wholeView.addSubview(typeLabel)
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(oneLinerTextField.snp.bottom).offset(50)
            $0.leading.equalToSuperview()
        }
        
        wholeView.addSubview(typeView)
        typeView.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(64)
        }
        
        typeView.addSubview(typeStackView)
        typeStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
        
        typeStackView.addArrangedSubview(typeLikeButton)
        typeLikeButton.snp.makeConstraints {
            $0.width.equalTo(44)
        }
        typeStackView.addArrangedSubview(typeCuriousButton)
        typeCuriousButton.snp.makeConstraints {
            $0.width.equalTo(44)
        }
        typeStackView.addArrangedSubview(typeWarningButton)
        typeWarningButton.snp.makeConstraints {
            $0.width.equalTo(44)
        }
        
        wholeView.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == menuTextField {
            oneLinerTextField.becomeFirstResponder()
        } else {
            oneLinerTextField.resignFirstResponder()
        }
        return true
    }
    
    // MARK: @objc
    
    @objc func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func tappedLike(button: UIButton) {
        selectedLike = !selectedLike

        if selectedLike {
            type = "like"
            typeLikeButton.setImage(UIImage(named: "likeFill"), for: .normal)
            typeCuriousButton.setImage(UIImage(named: "curious"), for: .normal)
            typeWarningButton.setImage(UIImage(named: "warning"), for: .normal)
        } else {
            type = nil
            typeLikeButton.setImage(UIImage(named: "like"), for: .normal)
        }

    }

    @objc func tappedCurious(button: UIButton) {
        selectedCurious = !selectedCurious

        if selectedCurious {
            type = "curious"
            typeLikeButton.setImage(UIImage(named: "like"), for: .normal)
            typeCuriousButton.setImage(UIImage(named: "curiousFill"), for: .normal)
            typeWarningButton.setImage(UIImage(named: "warning"), for: .normal)
        } else {
            type = nil
            typeCuriousButton.setImage(UIImage(named: "curious"), for: .normal)
        }

    }

    @objc func tappedWarning(button: UIButton) {
        selectedWarning = !selectedWarning

        if selectedWarning {
            type = "warning"
            typeLikeButton.setImage(UIImage(named: "like"), for: .normal)
            typeCuriousButton.setImage(UIImage(named: "curious"), for: .normal)
            typeWarningButton.setImage(UIImage(named: "warningFill"), for: .normal)
        } else {
            type = nil
            typeWarningButton.setImage(UIImage(named: "warning"), for: .normal)
        }

    }
    
    @objc func doneTapped() {
        
        var menuId = 0
            
        if menuTextField.text == "" {
            self.view.makeToast("메뉴명을 입력 해주세요.", position: .top)
            return
        } else if oneLinerTextField.text == "" {
            self.view.makeToast("한줄팁을 입력 해주세요.", position: .top)
            return
        }
        
        // FoodDetail 타입별 수정, 삭제를 고유 id로 판단
        if selectedRestaurant.menu.isEmpty {
            menuId = 1
        } else {
            menuId = selectedRestaurant.menu.last!.id + 1
        }

        guard let menuName = menuTextField.text else { return }
        guard let oneLiner = oneLinerTextField.text else { return }
        guard let type = self.type else {
            self.view.makeToast("평가버튼을 눌러 주세요.", position: .top)
            return }
        
        let menu: Menus = Menus(id: menuId,
                                menu: menuName,
                                oneLiner: oneLiner,
                                type: type
                                )
    
        UserDefaultsManager.shared.addMenu(selectedRestaurant: selectedRestaurant,
                                           selectedIndex: selectedIndex,
                                           addedMenu: menu)
        
        
        dismiss(animated: true, completion: nil)
    }

}

// MARK: Extension

//#if DEBUG
//
//import SwiftUI
//@available(iOS 13.0, *)
//
//// UIViewControllerRepresentable을 채택
//struct MenuAddViewControllerRepresentable: UIViewControllerRepresentable {
//    // update
//    // _ uiViewController: UIViewController로 지정
//    func updateUIViewController(_ uiViewController: UIViewController , context: Context) {
//
//    }
//    // makeui
//    func makeUIViewController(context: Context) -> UIViewController {
//    // Preview를 보고자 하는 Viewcontroller 이름
//    // e.g.)
//        let menuAddVC = MenuAddViewController(with: Restaurants.)
//        return menuAddVC
//
//    }
//}
//
//struct MenuAddViewController_Previews: PreviewProvider {
//
//    @available(iOS 13.0, *)
//    static var previews: some View {
//        // UIViewControllerRepresentable에 지정된 이름.
//        MenuAddViewControllerRepresentable()
//
//// 테스트 해보고자 하는 기기
//            .previewDevice("iPhone 12")
//    }
//}
//#endif