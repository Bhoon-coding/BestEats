//
//  MenuDetailViewController.swift
//  Besteats
//
//  Created by BH on 2022/03/28.
//

import UIKit

import SnapKit

class MenuDetailViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    
    var selectedLike: Bool = false
    var selectedCurious: Bool = false
    var selectedWarning: Bool = false
    var type: String? = nil
    var selectedMenu: Menu

    init(selectedMenu: Menu) {
        self.selectedMenu = selectedMenu
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var wholeView: UIView = {
        let view = UIView()
        return view
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
        button.setTitle("메뉴 추가", for: .normal)
        button.mediumButton(button: button)
        button.tintColor = .label
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        return button
    }()

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpUI()
        setUpDelegate()
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Methods
    
    private func setUpUI() {
        
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubview(wholeView)
        wholeView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(24)
        }
        
        wholeView.addSubview(menuLabel)
        menuLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
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
    
    private func setUpDelegate() {
        menuTextField.delegate = self
        oneLinerTextField.delegate = self
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
        
//        var menuId = 0
//        var menuName = ""
//        var oneLiner = ""
//
//        guard let inputMenuName = menuTextField.text else { return }
//        guard let inputOneLiner = oneLinerTextField.text else { return }
//        guard let type = self.type else {
//            self.view.makeToast("평가버튼을 눌러 주세요.", position: .top)
//            return }
//
//        if !inputMenuName.trimmingCharacters(in: .whitespaces).isEmpty {
//            menuName = inputMenuName.trimmingCharacters(in: .whitespaces)
//        } else {
//            view.makeToast("메뉴명을 입력 해주세요.", position: .top)
//            return
//        }
//
//        if !inputOneLiner.trimmingCharacters(in: .whitespaces).isEmpty {
//            oneLiner = inputOneLiner.trimmingCharacters(in: .whitespaces)
//        } else {
//            view.makeToast("한줄팁을 입력 해주세요.", position: .top)
//            return
//        }
//
//        if type == "like" {
//            if selectedRestaurant.likeMenus.isEmpty {
//                menuId = 1
//            } else {
//                menuId = selectedRestaurant.likeMenus.last!.id + 1
//            }
//            let alert = UIAlertController(title: "즐겨찾기",
//                                          message: "즐겨찾는 메뉴로 등록 하시겠습니까?",
//                                          preferredStyle: .alert)
//            let confirm = UIAlertAction(title: "등록", style: .default) {_ in
//                let menu: Menu = Menu(id: menuId,
//                                        isFavorite: true,
//                                        menu: menuName,
//                                        oneLiner: oneLiner
//                                        )
//                UserDefaultsManager.shared.addMenu(selectedRestaurant: self.selectedRestaurant,
//                                                   selectedIndex: self.selectedIndex,
//                                                   type: type,
//                                                   addedMenu: menu)
//                self.dismiss(animated: true, completion: nil)
//            }
//            let cancel = UIAlertAction(title: "등록안함", style: .destructive) {_ in
//                self.dismiss(animated: true, completion: nil)
//            }
//
//            alert.addAction(cancel)
//            alert.addAction(confirm)
//            DispatchQueue.main.async {
//                self.present(alert, animated: true, completion: nil)
//            }
//
//        } else if type == "curious" {
//            if selectedRestaurant.curiousMenus.isEmpty {
//                menuId = 1
//            } else {
//                menuId = selectedRestaurant.curiousMenus.last!.id + 1
//            }
//            dismiss(animated: true, completion: nil)
//        } else {
//            if selectedRestaurant.badMenus.isEmpty {
//                menuId = 1
//            } else {
//                menuId = selectedRestaurant.badMenus.last!.id + 1
//            }
//            dismiss(animated: true, completion: nil)
//        }
//
//        let menu: Menu = Menu(id: menuId,
//                                isFavorite: false,
//                                menu: menuName,
//                                oneLiner: oneLiner
//                                )
//        UserDefaultsManager.shared.addMenu(selectedRestaurant: selectedRestaurant,
//                                           selectedIndex: selectedIndex,
//                                           type: type,
//                                           addedMenu: menu)
//
    }

}
