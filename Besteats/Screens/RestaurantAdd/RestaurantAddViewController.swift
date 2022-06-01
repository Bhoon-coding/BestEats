//
//  RestaurantAddViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/30.
//

import UIKit

import SnapKit
import Toast_Swift

final class RestaurantAddViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Enums
    
    private enum Info {
        enum Label {
            static let restaurant: String = "맛집명"
            static let menu: String = "메뉴명"
            static let oneLiner: String = "한줄평"
            static let rating: String = "내평가"
        }
        
        enum Placeholder {
            static let restaurant: String = "맛집을 입력해 주세요."
            static let menu: String = "메뉴를 입력해 주세요."
            static let oneLiner: String = "한줄팁을 입력해 주세요."
        }
        
        enum RatingType {
            static let like: String = "like"
            static let curious: String = "curious"
            static let warning: String = "warning"
        }
        
        enum Button {
            static let addRestaurant: String = "맛집 추가"
        }
    }
    
    private enum Toast {
        static let requestRatingMsg: String = "평가버튼을 눌러 주세요."
        static let requestRestaurantMsg: String = "맛집명을 입력해 주세요."
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
    
    // MARK: Properties
    
    private var selectedLike: Bool = false
    private var selectedCurious: Bool = false
    private var selectedWarning: Bool = false
    private var type: String? = nil
    private var totalRestaurants: [Restaurant] = []
    
    private lazy var wholeView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var restaurantLabel: UILabel = {
        let label = UILabel()
        label.text = Info.Label.restaurant
        label.mediumLabel(label: label)
        return label
    }()
    
    private lazy var restaurantTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Info.Placeholder.restaurant
        textField.placeholderConvention(textField: textField)
        return textField
    }()
    
    private lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.text = Info.Label.menu
        label.mediumLabel(label: label)
        return label
    }()
    
    private lazy var menuTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Info.Placeholder.menu
        textField.placeholderConvention(textField: textField)
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
        textField.placeholder = Info.Placeholder.oneLiner
        textField.placeholderConvention(textField: textField)
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
        button.setImage(UIImage(named: Info.RatingType.like), for: .normal)
        button.addTarget(self, action: #selector(tappedLike(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var typeCuriousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Info.RatingType.curious), for: .normal)
        button.addTarget(self, action: #selector(tappedCurious(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var typeWarningButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Info.RatingType.warning), for: .normal)
        button.addTarget(self, action: #selector(tappedWarning(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle(Info.Button.addRestaurant, for: .normal)
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
        
        let menuId = 0
        var restaurantName = ""
        var menuName = ""
        var oneLiner = ""
        
        guard let inputRestaurant = restaurantTextField.text else { return }
        guard let inputMenuName = menuTextField.text else { return }
        guard let inputOneLiner = oneLinerTextField.text else { return }
        guard let type = self.type else {
            self.view.makeToast(Toast.requestRatingMsg, position: .top)
            return }
        
        if !inputRestaurant.trimmingCharacters(in: .whitespaces).isEmpty {
            restaurantName = inputRestaurant.trimmingCharacters(in: .whitespaces)
            
        } else {
            view.makeToast(Toast.requestRestaurantMsg, position: .top)
            return
        }
        
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
        
        var menus: [Menu] = [Menu(id: menuId + 1,
                                  isFavorite: false,
                                  menu: menuName,
                                  oneLiner: oneLiner
                                 )]
        
        if type == Info.RatingType.like {
            let alert = UIAlertController(title: Alert.Favorite.title, message: Alert.Favorite.message, preferredStyle: .alert)
            let confirm = UIAlertAction(title: Alert.Favorite.confirm, style: .default) {_ in
                menus[0].isFavorite = true
                
                let restaurant: Restaurant = Restaurant(restaurantName: restaurantName,
                                                        type: Info.RatingType.like,
                                                        likeMenus: menus,
                                                        curiousMenus: [],
                                                        badMenus: [])
                
                UserDefaultsManager.shared.addRestaurant(restaurant: restaurant)
                self.dismiss(animated: true, completion: nil)
            }
            let cancel = UIAlertAction(title: Alert.Favorite.cancel, style: .destructive) {_ in
                let restaurant: Restaurant = Restaurant(restaurantName: restaurantName,
                                                        type: Info.RatingType.like,
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
            
        } else if type == Info.RatingType.curious {
            let restaurant: Restaurant = Restaurant(restaurantName: restaurantName,
                                                    type: Info.RatingType.curious,
                                                    likeMenus: [],
                                                    curiousMenus: menus,
                                                    badMenus: [])
            
            UserDefaultsManager.shared.addRestaurant(restaurant: restaurant)
            dismiss(animated: true, completion: nil)
            
        } else {
            let restaurant: Restaurant = Restaurant(restaurantName: restaurantName,
                                                    type: Info.RatingType.warning,
                                                    likeMenus: [],
                                                    curiousMenus: [],
                                                    badMenus: menus)
            
            UserDefaultsManager.shared.addRestaurant(restaurant: restaurant)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
}
