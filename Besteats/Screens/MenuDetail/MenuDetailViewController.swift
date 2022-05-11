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
    
    var editMode: Bool = false
    var selectedLike: Bool = false
    var selectedCurious: Bool = false
    var selectedWarning: Bool = false
    var type: String? = nil
    var selectedRestaurant: Restaurant
    var selectedMenu: Menu

    init(selectedRestaurant: Restaurant, selectedMenu: Menu) {
        self.selectedRestaurant = selectedRestaurant
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
        textField.placeholderConvention(textField: textField)
        textField.isUserInteractionEnabled = false
        textField.text = selectedMenu.menu
        textField.backgroundColor = .secondarySystemBackground
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
        textField.placeholderConvention(textField: textField)
        textField.isUserInteractionEnabled = false
        textField.text = selectedMenu.oneLiner
        textField.backgroundColor = .secondarySystemBackground
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

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpNavigationBar()
        setUpUI()
        setUpDelegate()
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Methods
    
    private func setUpNavigationBar() {
        let smallFontAttributes = [NSAttributedString.Key.font: UIFont(name: "GmarketSansBold",
                                                                       size: 14)!]
        let modifyButton = UIBarButtonItem(title: "수정",
                                           style: .plain,
                                           target: self,
                                           action: #selector(editTapped))
        
        modifyButton.setTitleTextAttributes(smallFontAttributes, for: .normal)
        
        navigationItem.rightBarButtonItem = modifyButton
        title = selectedRestaurant.restaurantName
    }
    
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

//        wholeView.addSubview(setMenuView)
//        setMenuView.snp.makeConstraints {
//            $0.top.equalTo(menuLabel.snp.bottom).offset(24)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(44)
//        }
//
//        setMenuView.addSubview(setMenuLabel)
//        setMenuLabel.snp.makeConstraints {
//            $0.leading.equalTo(10)
//            $0.centerY.equalToSuperview()
//        }
        
//        wholeView.addSubview(oneLinerLabel)
//        oneLinerLabel.snp.makeConstraints {
//            $0.top.equalTo(setMenuView.snp.bottom).offset(50)
//            $0.leading.equalToSuperview()
//        }

        
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
    
    func changeTextField() {
        self.menuTextField.isUserInteractionEnabled = editMode ? true : false
        self.menuTextField.backgroundColor = editMode ? .white : .secondarySystemBackground
        self.menuTextField.text = self.selectedMenu.menu

        self.oneLinerTextField.isUserInteractionEnabled = false
        self.oneLinerTextField.backgroundColor = .secondarySystemBackground
        self.oneLinerTextField.text = self.selectedMenu.oneLiner
    }
    
    
    // MARK: @objc
    
    @objc func editTapped() {
        
        editMode = true
        let smallFontAttributes = [NSAttributedString.Key.font: UIFont(name: "GmarketSansBold",
                                                                       size: 14)!]
        let doneButton = UIBarButtonItem(title: "완료",
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneTapped))
        doneButton.setTitleTextAttributes(smallFontAttributes, for: .normal)
        navigationItem.rightBarButtonItem = doneButton
        menuTextField.isUserInteractionEnabled = true
        menuTextField.backgroundColor = .white
        menuTextField.placeholder = selectedMenu.menu
        
        oneLinerTextField.isUserInteractionEnabled = true
        oneLinerTextField.backgroundColor = .white
        oneLinerTextField.placeholder = selectedMenu.oneLiner
    }
    
    @objc func doneTapped() {
        
        editMode = false
        let smallFontAttributes = [NSAttributedString.Key.font: UIFont(name: "GmarketSansBold",
                                                                       size: 14)!]
        let editButton = UIBarButtonItem(title: "수정",
                                           style: .plain,
                                           target: self,
                                         action: #selector(self.editTapped))

        editButton.setTitleTextAttributes(smallFontAttributes, for: .normal)
        
        let alert = UIAlertController(title: "변경사항을 저장 하시겠습니까?",
                                      message: "",
                                      preferredStyle: .alert)
        let confirm = UIAlertAction(title: "저장",
                                    style: .default) { action in
            self.navigationItem.rightBarButtonItem = editButton
            self.changeTextField()
        }
        let cancel = UIAlertAction(title: "취소",
                                   style: .cancel) { action in
            self.navigationItem.rightBarButtonItem = editButton
            self.changeTextField()
        }
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
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

}
