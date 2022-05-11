//
//  RestaurantAddViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/30.
//

import UIKit

import SnapKit
import Toast_Swift


class RestaurantAddViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    var selectedLike: Bool = false
    var selectedCurious: Bool = false
    var selectedWarning: Bool = false
    var type: String? = nil
    var totalRestaurants: [Restaurant] = []
    
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
        label.text = "맛집명"
        label.mediumLabel(label: label)
        return label
    }()
    
    lazy var restaurantTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "맛집을 입력해 주세요."
        textField.placeholderConvention(textField: textField)
        return textField
    }()
    
    lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.text = "메뉴명"
        label.mediumLabel(label: label)
        return label
    }()
    
    lazy var menuTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "메뉴를 입력해 주세요."
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
        textField.placeholder = "한줄팁을 입력해 주세요."
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
        button.setTitle("맛집 추가", for: .normal)
        button.mediumButton(button: button)
        button.tintColor = .label
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalRestaurants = UserDefaultsManager.shared.getRestaurants()
        
        restaurantTextField.delegate = self
        menuTextField.delegate = self
        oneLinerTextField.delegate = self
        
        setUpUI()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Methods
    
    private func setUpUI() {
        
        view.backgroundColor = .secondarySystemBackground
        
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
            $0.top.equalTo(closeButton.snp.bottom).offset(36)
            $0.leading.equalToSuperview()
        }
        
        wholeView.addSubview(restaurantTextField)
        restaurantTextField.snp.makeConstraints {
            $0.top.equalTo(restaurantLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        wholeView.addSubview(menuLabel)
        menuLabel.snp.makeConstraints {
            $0.top.equalTo(restaurantTextField.snp.bottom).offset(36)
            $0.leading.equalToSuperview()
        }
        
        wholeView.addSubview(menuTextField)
        menuTextField.snp.makeConstraints {
            $0.top.equalTo(menuLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        wholeView.addSubview(oneLinerLabel)
        oneLinerLabel.snp.makeConstraints {
            $0.top.equalTo(menuTextField.snp.bottom).offset(36)
            $0.leading.equalToSuperview()
        }
        
        wholeView.addSubview(oneLinerTextField)
        oneLinerTextField.snp.makeConstraints {
            $0.top.equalTo(oneLinerLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        wholeView.addSubview(typeLabel)
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(oneLinerTextField.snp.bottom).offset(36)
            $0.leading.equalToSuperview()
        }
        
        wholeView.addSubview(typeView)
        typeView.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(16)
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
        if textField == restaurantTextField {
            menuTextField.becomeFirstResponder()
        } else if textField == menuTextField {
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
        
        let menuId = 0
        var restaurantName = ""
        var menuName = ""
        var oneLiner = ""
        
        guard let inputRestaurant = restaurantTextField.text else { return }
        guard let inputMenuName = menuTextField.text else { return }
        guard let inputOneLiner = oneLinerTextField.text else { return }
        guard let type = self.type else {
            self.view.makeToast("평가버튼을 눌러 주세요.", position: .top)
            return }
        
        if !inputRestaurant.trimmingCharacters(in: .whitespaces).isEmpty {
            restaurantName = inputRestaurant.trimmingCharacters(in: .whitespaces)
            
        } else {
            view.makeToast("맛집명을 입력 해주세요.", position: .top)
            return
        }
        
        if !inputMenuName.trimmingCharacters(in: .whitespaces).isEmpty {
            menuName = inputMenuName.trimmingCharacters(in: .whitespaces)
        } else {
            view.makeToast("메뉴명을 입력 해주세요.", position: .top)
            return
        }
        
        if !inputOneLiner.trimmingCharacters(in: .whitespaces).isEmpty {
            oneLiner = inputOneLiner.trimmingCharacters(in: .whitespaces)
        } else {
            view.makeToast("한줄팁을 입력 해주세요.", position: .top)
            return
        }
        
        var menus: [Menu] = [Menu(id: menuId + 1,
                                  isFavorite: false,
                                  menu: menuName,
                                  oneLiner: oneLiner
                                 )]
        
        if type == "like" {
            let alert = UIAlertController(title: "즐겨찾기", message: "즐겨찾는 메뉴로 등록 하시겠습니까?", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "등록", style: .default) {_ in
                menus[0].isFavorite = true
                
                let restaurant: Restaurant = Restaurant(restaurantName: restaurantName,
                                                        type: "like",
                                                        likeMenus: menus,
                                                        curiousMenus: [],
                                                        badMenus: [])
                
                UserDefaultsManager.shared.addRestaurant(restaurant: restaurant)
                self.dismiss(animated: true, completion: nil)
            }
            let cancel = UIAlertAction(title: "등록안함", style: .destructive) {_ in
                let restaurant: Restaurant = Restaurant(restaurantName: restaurantName,
                                                        type: "like",
                                                        likeMenus: menus,
                                                        curiousMenus: [],
                                                        badMenus: [])
                
                UserDefaultsManager.shared.addRestaurant(restaurant: restaurant)
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(cancel)
            alert.addAction(confirm)
            
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
            
        } else if type == "curious" {
            let restaurant: Restaurant = Restaurant(restaurantName: restaurantName,
                                                    type: "curious",
                                                    likeMenus: [],
                                                    curiousMenus: menus,
                                                    badMenus: [])
            
            UserDefaultsManager.shared.addRestaurant(restaurant: restaurant)
            dismiss(animated: true, completion: nil)
            
        } else {
            let restaurant: Restaurant = Restaurant(restaurantName: restaurantName,
                                                    type: "warning",
                                                    likeMenus: [],
                                                    curiousMenus: [],
                                                    badMenus: menus)
            
            UserDefaultsManager.shared.addRestaurant(restaurant: restaurant)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
}
