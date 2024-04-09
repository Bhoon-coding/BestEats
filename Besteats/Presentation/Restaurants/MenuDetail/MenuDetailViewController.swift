//
//  MenuDetailViewController.swift
//  Besteats
//
//  Created by BH on 2022/03/28.
//

import UIKit

import SnapKit
import Toast_Swift

final class MenuDetailViewController: UIViewController {
    
    // MARK: - Enums
    
    private enum Navigation {
        enum Button {
            static let save: String = "저장"
            static let edit: String = "수정"
        }
    }
    
    private enum Info {
        enum Label {
            static let menu: String = "메뉴명"
            static let oneLiner: String = "한줄평"
            static let rating: String = "내평가"
        }
        enum Placeholder {
            static let menu: String = "메뉴를 입력해 주세요."
            static let oneLiner: String = "한줄평을 입력해 주세요."
        }
    }
    
    private enum Toast {
        static let requestMenuMsg: String = "메뉴명을 입력해 주세요."
        static let requestOneLinerMsg: String = "한줄평을 입력해 주세요."
    }
    
    private enum Alert {
        enum Save {
            static let title: String = "변경사항을 저장 하시겠습니까?"
        }
        enum Button {
            static let save: String = "저장"
            static let cancel: String = "취소"
        }
    }

    // MARK: Properties

    private var editMode: Bool = false
    private var selectedLike: Bool = false
    private var selectedCurious: Bool = false
    private var selectedWarning: Bool = false
    
    var selectedRestaurant: Restaurant
    var selectedRestaurantIndex: Int
    var selectedMenu: Menu
    var selectedMenuIndex: Int
    var prevType: String
    var changeType: String = ""

    init(selectedRestaurant: Restaurant,
         selectedRestaurantIndex: Int,
         selectedMenu: Menu,
         selectedMenuIndex: Int,
         prevType: String) {
        self.selectedRestaurant = selectedRestaurant
        self.selectedRestaurantIndex = selectedRestaurantIndex
        self.selectedMenu = selectedMenu
        self.selectedMenuIndex = selectedMenuIndex
        self.prevType = prevType
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var wholeView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.text = Info.Label.menu
        label.mediumLabel(label: label)
        return label
    }()
    
    private lazy var menuTextField: UITextField = {
        let textField = UITextField()
        textField.placeholderConvention(textField: textField)
        textField.isUserInteractionEnabled = false
        textField.text = selectedMenu.menu
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private lazy var oneLinerLabel: UILabel = {
        let label = UILabel()
        label.text = Info.Label.oneLiner
        label.mediumLabel(label: label)
        return label
    }()
    
    private lazy var oneLinerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholderConvention(textField: textField)
        textField.isUserInteractionEnabled = false
        textField.text = selectedMenu.oneLiner
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = Info.Label.rating
        label.mediumLabel(label: label)
        return label
    }()
    
    private lazy var typeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var typeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var typeLikeButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setImage(UIImage(named: prevType == Image.like ? Image.likeFill : Image.like), for: .normal)
        button.addTarget(self, action: #selector(tappedLike(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var typeCuriousButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setImage(UIImage(named: prevType == Image.curious ? Image.curiousFill : Image.curious), for: .normal)
        button.addTarget(self, action: #selector(tappedCurious(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var typeWarningButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setImage(UIImage(named: prevType == Image.warning ? Image.warningFill : Image.warning), for: .normal)
        button.addTarget(self, action: #selector(tappedWarning(button:)), for: .touchUpInside)
        return button
    }()

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureNavigationBar()
        configureUI()
        configureDelegate()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Methods
    
    private func configureNavigationBar() {
        let smallFontAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.bold,
                                                                       size: 14)!]
        let editButton = UIBarButtonItem(title: Navigation.Button.edit,
                                           style: .plain,
                                           target: self,
                                           action: #selector(editTapped))
        
        editButton.setTitleTextAttributes(smallFontAttributes, for: .normal)
        
        navigationItem.rightBarButtonItem = editButton
        title = selectedRestaurant.restaurantName
    }
    
    private func configureDelegate() {
        menuTextField.delegate = self
        oneLinerTextField.delegate = self
    }
    
    private func navRightBarSaveButton() {
        let smallFontAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.bold,
                                                                       size: 14)!]
        let saveButton = UIBarButtonItem(title: Navigation.Button.save,
                                         style: .plain,
                                         target: self,
                                         action: #selector(saveTapped))
        saveButton.setTitleTextAttributes(smallFontAttributes, for: .normal)
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func navRightBarEditButton() {
        let smallFontAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.bold,
                                                                       size: 14)!]
        let editButton = UIBarButtonItem(title: Navigation.Button.edit,
                                           style: .plain,
                                           target: self,
                                         action: #selector(self.editTapped))

        editButton.setTitleTextAttributes(smallFontAttributes, for: .normal)
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    private func activeLikeButton() {
        typeLikeButton.setImage(UIImage(named: Image.likeFill), for: .normal)
        typeCuriousButton.setImage(UIImage(named: Image.curious), for: .normal)
        typeWarningButton.setImage(UIImage(named: Image.warning), for: .normal)
    }
    
    private func activeCuriousButton() {
        typeLikeButton.setImage(UIImage(named: Image.like), for: .normal)
        typeCuriousButton.setImage(UIImage(named: Image.curiousFill), for: .normal)
        typeWarningButton.setImage(UIImage(named: Image.warning), for: .normal)
    }
    
    private func activeWarningButton() {
        typeLikeButton.setImage(UIImage(named: Image.like), for: .normal)
        typeCuriousButton.setImage(UIImage(named: Image.curious), for: .normal)
        typeWarningButton.setImage(UIImage(named: Image.warningFill), for: .normal)
    }
    
    private func changeTextField() {
        menuTextField.isUserInteractionEnabled = editMode ? true : false
        menuTextField.backgroundColor = editMode ? .white : .secondarySystemBackground
        menuTextField.text = editMode ? selectedMenu.menu : menuTextField.text

        oneLinerTextField.isUserInteractionEnabled = editMode ? true : false
        oneLinerTextField.backgroundColor = editMode ? .white : .secondarySystemBackground
        oneLinerTextField.text = editMode ? selectedMenu.oneLiner : oneLinerTextField.text
        
        typeView.backgroundColor = editMode ? .white : .secondarySystemBackground
        
        typeLikeButton.isEnabled = true
        typeCuriousButton.isEnabled = true
        typeWarningButton.isEnabled = true
    }
    
    private func saveCancel() {
        switch prevType {
        case Image.like:
            activeLikeButton()
        case Image.curious:
            activeCuriousButton()
        default:
            activeWarningButton()
        }
        menuTextField.isUserInteractionEnabled = editMode ? true : false
        menuTextField.backgroundColor = editMode ? .white : .secondarySystemBackground
        menuTextField.text = selectedMenu.menu

        oneLinerTextField.isUserInteractionEnabled = false
        oneLinerTextField.backgroundColor = .secondarySystemBackground
        oneLinerTextField.text = selectedMenu.oneLiner
        
        typeView.backgroundColor = editMode ? .white : .secondarySystemBackground
        
        typeLikeButton.isEnabled = false
        typeCuriousButton.isEnabled = false
        typeWarningButton.isEnabled = false
    }
    
    // MARK: @objc
    
    @objc func editTapped() {
        
        editMode = true
        if editMode {
            navRightBarSaveButton()
        }
        menuTextField.isUserInteractionEnabled = true
        menuTextField.backgroundColor = .white
        menuTextField.placeholder = selectedMenu.menu
        
        oneLinerTextField.isUserInteractionEnabled = true
        oneLinerTextField.backgroundColor = .white
        oneLinerTextField.placeholder = selectedMenu.oneLiner
        
        typeView.backgroundColor = .white
        typeLikeButton.isEnabled = true
        typeCuriousButton.isEnabled = true
        typeWarningButton.isEnabled = true
    }
    
    @objc func saveTapped() {
        
        editMode = false
        
        let alert = UIAlertController(title: Alert.Save.title,
                                      message: "",
                                      preferredStyle: .alert)
        let confirm = UIAlertAction(title: Alert.Button.save,
                                    style: .default) { action in
            self.navRightBarEditButton()
            
            guard let editedMenuName = self.menuTextField.text,
                  let editedOnliner = self.oneLinerTextField.text else { return }
            
            if editedMenuName.trimmingCharacters(in: .whitespaces).isEmpty {
                self.view.makeToast(Toast.requestMenuMsg, position: .top)
                self.editMode = true
                self.navRightBarSaveButton()
                self.changeTextField()
                return
                
            } else if editedOnliner.trimmingCharacters(in: .whitespaces).isEmpty {
                self.view.makeToast(Toast.requestOneLinerMsg, position: .top)
                self.editMode = true
                self.navRightBarSaveButton()
                self.changeTextField()
                return
            }
            self.changeTextField()
            let editMenu = Menu(id: self.selectedMenu.id,
                                  isFavorite: self.selectedMenu.isFavorite,
                                  menu: editedMenuName,
                                  oneLiner: editedOnliner)
            
            UserDefaultsManager.shared.updateMenu(selectedRestaurant: self.selectedRestaurant,
                                                  selectedRestauransIndex: self.selectedRestaurantIndex,
                                                  prevType: self.prevType,
                                                  changeType: self.changeType,
                                                  editedMenu: editMenu,
                                                  menuIndex: self.selectedMenuIndex)
        }
        let cancel = UIAlertAction(title: Alert.Button.cancel,
                                   style: .cancel) { action in
            self.navRightBarEditButton()
            self.saveCancel()
        }
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func tappedLike(button: UIButton) {
        selectedLike = true
        if selectedLike {
            changeType = Image.like
            activeLikeButton()
        } else {
            typeLikeButton.setImage(UIImage(named: Image.like), for: .normal)
        }
    }

    @objc func tappedCurious(button: UIButton) {
        selectedCurious = true
        if selectedCurious {
            changeType = Image.curious
           activeCuriousButton()
        } else {
            typeCuriousButton.setImage(UIImage(named: Image.curious), for: .normal)
        }
    }

    @objc func tappedWarning(button: UIButton) {
        selectedWarning = true
        if selectedWarning {
            changeType = Image.warning
            activeWarningButton()
        } else {
            typeWarningButton.setImage(UIImage(named: Image.warning), for: .normal)
        }
    }
}

// MARK: - Extension

extension MenuDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == menuTextField {
            oneLinerTextField.becomeFirstResponder()
        } else {
            oneLinerTextField.resignFirstResponder()
        }
        return true
    }
}

extension MenuDetailViewController {
    
    private func configureUI() {
        
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
    }
}
