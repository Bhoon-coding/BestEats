//
//  MenuAddViewController.swift
//  Besteats
//
//  Created by BH on 2022/03/15.
//

import UIKit

import SnapKit
import Toast_Swift

final class MenuAddViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Enums
    
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
        enum RatingType {
            static let like: String = "like"
            static let curious: String = "curious"
            static let warning: String = "warning"
        }
        enum Button {
            static let addMenu: String = "메뉴 추가"
        }
    }
    
    private enum Toast {
        static let requestRatingMsg: String = "평가버튼을 눌러 주세요."
        static let requestMenuMsg: String = "메뉴명을 입력해 주세요."
        static let requestOneLinerMsg: String = "한줄평을 입력해 주세요."
    }
    
    private enum Alert {
        enum Favorite {
            static let title: String = "즐겨찾기"
            static let message: String = "즐겨찾는 메뉴로 등록 하시겠습니까?"
            static let confirm: String = "등록"
            static let cancel: String = "등록안함"
        }
    }
    
    // MARK: - Properties
    
    private var selectedLike: Bool = false
    private var selectedCurious: Bool = false
    private var selectedWarning: Bool = false
    private var type: String? = nil
    private var selectedIndex: Int
    private var selectedRestaurant: Restaurant
    
    init(selectedRestaurant: Restaurant, selectedIndex: Int) {
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
        button.setImage(UIImage(named: Image.close), for: .normal)
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var restaurantLabel: UILabel = {
        let label = UILabel()
        label.text = "\(selectedRestaurant.restaurantName)"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.text = Info.Label.menu
        label.mediumLabel(label: label)
        return label
    }()
    
    lazy var menuTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Info.Placeholder.menu
        textField.placeholderConvention(textField: textField)
        return textField
    }()
    
    lazy var oneLinerLabel: UILabel = {
        let label = UILabel()
        label.text = Info.Label.oneLiner
        label.mediumLabel(label: label)
        return label
    }()
    
    lazy var oneLinerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Info.Placeholder.oneLiner
        textField.placeholderConvention(textField: textField)
        return textField
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = Info.Label.rating
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
        button.setImage(UIImage(named: Image.like), for: .normal)
        button.addTarget(self, action: #selector(tappedLike(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var typeCuriousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Image.curious), for: .normal)
        button.addTarget(self, action: #selector(tappedCurious(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var typeWarningButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Image.warning), for: .normal)
        button.addTarget(self, action: #selector(tappedWarning(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle(Info.Button.addMenu, for: .normal)
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
            type = Info.RatingType.like
            typeLikeButton.setImage(UIImage(named: Image.likeFill), for: .normal)
            typeCuriousButton.setImage(UIImage(named: Image.curious), for: .normal)
            typeWarningButton.setImage(UIImage(named: Image.warning), for: .normal)
        } else {
            type = nil
            typeLikeButton.setImage(UIImage(named: Image.like), for: .normal)
        }
    }

    @objc func tappedCurious(button: UIButton) {
        selectedCurious = !selectedCurious

        if selectedCurious {
            type = Info.RatingType.curious
            typeLikeButton.setImage(UIImage(named: Image.like), for: .normal)
            typeCuriousButton.setImage(UIImage(named: Image.curiousFill), for: .normal)
            typeWarningButton.setImage(UIImage(named: Image.warning), for: .normal)
        } else {
            type = nil
            typeCuriousButton.setImage(UIImage(named: Image.curious), for: .normal)
        }
    }

    @objc func tappedWarning(button: UIButton) {
        selectedWarning = !selectedWarning

        if selectedWarning {
            type = Info.RatingType.warning
            typeLikeButton.setImage(UIImage(named: Image.like), for: .normal)
            typeCuriousButton.setImage(UIImage(named: Image.curious), for: .normal)
            typeWarningButton.setImage(UIImage(named: Image.warningFill), for: .normal)
        } else {
            type = nil
            typeWarningButton.setImage(UIImage(named: Image.warning), for: .normal)
        }
    }
    
    @objc func doneTapped() {
        
        var menuId = 0
        var menuName = ""
        var oneLiner = ""

        guard let inputMenuName = menuTextField.text else { return }
        guard let inputOneLiner = oneLinerTextField.text else { return }
        guard let type = self.type else {
            self.view.makeToast(Toast.requestRatingMsg, position: .top)
            return }
        
        if !inputMenuName.trimmingCharacters(in: .whitespaces).isEmpty {
            menuName = inputMenuName.trimmingCharacters(in: .whitespaces)
        } else {
            view.makeToast(Toast.requestMenuMsg, position: .top)
            return
        }
        
        if !inputOneLiner.trimmingCharacters(in: .whitespaces).isEmpty {
            oneLiner = inputOneLiner.trimmingCharacters(in: .whitespaces)
        } else {
            view.makeToast(Toast.requestOneLinerMsg, position: .top)
            return
        }
        
        if type == Info.RatingType.like {
            if selectedRestaurant.likeMenus.isEmpty {
                menuId = 1
            } else {
                menuId = selectedRestaurant.likeMenus.last!.id + 1
            }
            let alert = UIAlertController(title: Alert.Favorite.title,
                                          message: Alert.Favorite.message,
                                          preferredStyle: .alert)
            let confirm = UIAlertAction(title: Alert.Favorite.confirm, style: .default) {_ in
                let menu: Menu = Menu(id: menuId,
                                        isFavorite: true,
                                        menu: menuName,
                                        oneLiner: oneLiner
                                        )
                UserDefaultsManager.shared.addMenu(selectedRestaurant: self.selectedRestaurant,
                                                   selectedIndex: self.selectedIndex,
                                                   type: type,
                                                   addedMenu: menu)
                self.dismiss(animated: true, completion: nil)
            }
            let cancel = UIAlertAction(title: Alert.Favorite.cancel, style: .destructive) {_ in
                self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(cancel)
            alert.addAction(confirm)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
            
        } else if type == "curious" {
            if selectedRestaurant.curiousMenus.isEmpty {
                menuId = 1
            } else {
                menuId = selectedRestaurant.curiousMenus.last!.id + 1
            }
            dismiss(animated: true, completion: nil)
        } else {
            if selectedRestaurant.badMenus.isEmpty {
                menuId = 1
            } else {
                menuId = selectedRestaurant.badMenus.last!.id + 1
            }
            dismiss(animated: true, completion: nil)
        }
        
        let menu: Menu = Menu(id: menuId,
                                isFavorite: false,
                                menu: menuName,
                                oneLiner: oneLiner
                                )
        UserDefaultsManager.shared.addMenu(selectedRestaurant: selectedRestaurant,
                                           selectedIndex: selectedIndex,
                                           type: type,
                                           addedMenu: menu)
        
    }

}
