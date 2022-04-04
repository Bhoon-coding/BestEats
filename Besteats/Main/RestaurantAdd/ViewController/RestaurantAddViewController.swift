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
    var totalRestaurant: [Restaurants] = []
    
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
    
    lazy var restuarantTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "맛집명을 입력해 주세요."
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
        
        totalRestaurant = UserDefaultsManager.shared.getRestaurants()
        
        restuarantTextField.delegate = self
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
            $0.top.equalTo(closeButton.snp.bottom).offset(50)
            $0.leading.equalToSuperview()
        }
        
        wholeView.addSubview(restuarantTextField)
        restuarantTextField.snp.makeConstraints {
            $0.top.equalTo(restaurantLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        wholeView.addSubview(menuLabel)
        menuLabel.snp.makeConstraints {
            $0.top.equalTo(restuarantTextField.snp.bottom).offset(50)
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
        if textField == restuarantTextField {
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
            
        if restuarantTextField.text == "" {
            self.view.makeToast("맛집명을 입력 해주세요.", position: .top)
            return
        } else if menuTextField.text == "" {
            self.view.makeToast("메뉴명을 입력 해주세요.", position: .top)
            return
        } else if oneLinerTextField.text == "" {
            self.view.makeToast("한줄팁을 입력 해주세요.", position: .top)
            return
        }
        
        guard let restaurantName = restuarantTextField.text else { return }
        guard let menuName = menuTextField.text else { return }
        guard let oneLiner = oneLinerTextField.text else { return }
        guard let type = self.type else {
            self.view.makeToast("평가버튼을 눌러 주세요.", position: .top)
            return }
        
        let menus: [Menus] = [Menus(id: menuId + 1,
                                isFavorite: false,
                                menu: menuName,
                                oneLiner: oneLiner,
                                type: type
                                )]
    
        let restaurant: Restaurants = Restaurants(restaurantName: restaurantName, menu: menus)
        UserDefaultsManager.shared.addRestaurant(restaurant: restaurant)
//
//
//        totalRestaurant.append(contentsOf: restaurants)
//        UserDefaultsManager.shared.saveRestaurants(restaurants: restaurants)
        
        
        dismiss(animated: true, completion: nil)
    }

}

//class RestaurantAddViewController: UIViewController, UITextFieldDelegate {
//
//    // MARK: Properties
//
//    // 변수추가시 preview 에러
//
//    var selectedLike: Bool = false
//    var selectedCurious: Bool = false
//    var selectedWarning: Bool = false
//    var type: String? = nil
//
//    var totalRestaurants: [Restaurants] = []
//    var menusData: [Menus] = []
//    var delegate: SendUpdateDelegate?
//
//    lazy var closeButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "close"), for: .normal)
//        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
//        return button
//    }()
//
//    lazy var restaurantNameWrapper: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 10
//        view.layer.borderWidth = 3
//        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09988100166)
//        return view
//    }()
//
//    lazy var restaurantNameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "맛집명:"
//        return label
//    }()
//
//    lazy var restaurantNameTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholderConvention(textField: textField)
//        textField.placeholder = "맛집 이름을 입력 해주세요."
//        textField.returnKeyType = .next
//        return textField
//    }()
//
//    lazy var menuWrapper: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 10
//        view.layer.borderWidth = 3
//        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09988100166)
//        return view
//    }()
//
//    lazy var menuLabel: UILabel = {
//        let label = UILabel()
//        label.text = "메뉴명:"
//        return label
//    }()
//
//    lazy var menuTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "메뉴 이름을 입력 해주세요."
//        textField.placeholderConvention(textField: textField)
//        textField.returnKeyType = .next
//        return textField
//    }()
//
//
//    lazy var oneLinerWrapper: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 10
//        view.layer.borderWidth = 3
//        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09988100166)
//        return view
//    }()
//
//    lazy var oneLinerLabel: UILabel = {
//        let label = UILabel()
//        label.text = "한줄팁:"
//        return label
//    }()
//
//    lazy var oneLinerTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "꿀팁을 입력 해주세요."
//        textField.returnKeyType = .done
//        textField.placeholderConvention(textField: textField)
//        return textField
//    }()
//
//    lazy var typeWrapper: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 10
//        view.layer.borderWidth = 3
//        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09988100166)
//        return view
//    }()
//
//    lazy var typeLabel: UILabel = {
//        let label = UILabel()
//        label.text = "내 평가:"
//        return label
//    }()
//
//    lazy var typeStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.distribution = .equalSpacing
//        return stackView
//    }()
//
//    lazy var typeLikeButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "like"), for: .normal)
//        button.addTarget(self, action: #selector(tappedLike(button:)), for: .touchUpInside)
//
//        return button
//    }()
//
//    lazy var typeCuriousButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "curious"), for: .normal)
//        button.addTarget(self, action: #selector(tappedCurious(button:)), for: .touchUpInside)
//        return button
//    }()
//
//    lazy var typeWarningButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "warning"), for: .normal)
//        button.addTarget(self, action: #selector(tappedWarning(button:)), for: .touchUpInside)
//        return button
//    }()
//
//    lazy var doneButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("완료", for: .normal)
//        button.tintColor = .label
//        button.backgroundColor = .systemGreen
//        button.layer.cornerRadius = 8
//        button.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
//        return button
//    }()
//
//    // MARK: LifeCycle
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        totalRestaurants = UserDefaultsManager.shared.getRestaurants()
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .secondarySystemBackground
//
//        restaurantNameTextField.delegate = self
//        menuTextField.delegate = self
//        oneLinerTextField.delegate = self
//
//        // 키보드 크기 따라 View 위로 올리기
////        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
////
////        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//        setUpUI()
//
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//
//    private func setUpUI() {
//
//
//        view.addSubview(closeButton)
//
//        view.addSubview(restaurantNameWrapper)
//        restaurantNameWrapper.addSubview(restaurantNameLabel)
//
//        restaurantNameWrapper.addSubview(restaurantNameTextField)
//
//        view.addSubview(menuWrapper)
//        menuWrapper.addSubview(menuLabel)
//        menuWrapper.addSubview(menuTextField)
//
//        view.addSubview(oneLinerWrapper)
//        oneLinerWrapper.addSubview(oneLinerLabel)
//        oneLinerWrapper.addSubview(oneLinerTextField)
//
//        view.addSubview(typeWrapper)
//        typeWrapper.addSubview(typeLabel)
//        typeWrapper.addSubview(typeStackView)
//        typeStackView.addArrangedSubview(typeLikeButton)
//        typeStackView.addArrangedSubview(typeCuriousButton)
//        typeStackView.addArrangedSubview(typeWarningButton)
//
//        view.addSubview(doneButton)
//
//        closeButton.snp.makeConstraints {
//            $0.leading.equalToSuperview().inset(24)
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
//            $0.size.equalTo(20)
//        }
//
//        restaurantNameWrapper.snp.makeConstraints {
//            $0.top.equalTo(closeButton.snp.top).inset(64)
//            $0.leading.trailing.equalToSuperview().inset(24)
//            $0.height.equalTo(100)
//        }
//
//        restaurantNameLabel.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.leading.equalToSuperview().inset(16)
//            $0.width.equalTo(80)
//            $0.height.equalTo(40)
//        }
//
//
//        restaurantNameTextField.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.leading.equalTo(restaurantNameLabel.snp.trailing).inset(16)
//            $0.trailing.equalToSuperview().inset(16)
//            $0.height.equalTo(restaurantNameLabel)
//        }
//
//
//
//        menuWrapper.snp.makeConstraints {
//            $0.top.equalTo(restaurantNameWrapper.snp.bottom).offset(24)
//            $0.leading.equalTo(restaurantNameWrapper.snp.leading)
//            $0.trailing.equalTo(restaurantNameWrapper.snp.trailing)
//            $0.height.equalTo(restaurantNameWrapper.snp.height)
//        }
//
//        menuLabel.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.leading.equalToSuperview().inset(16)
//            $0.width.equalTo(80)
//            $0.height.equalTo(40)
//        }
//
//        menuTextField.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.leading.equalTo(menuLabel.snp.trailing).inset(16)
//            $0.trailing.equalToSuperview().inset(16)
//            $0.height.equalTo(menuLabel)
//        }
//
//        oneLinerWrapper.snp.makeConstraints {
//            $0.top.equalTo(menuWrapper.snp.bottom).offset(24)
//            $0.leading.equalTo(menuWrapper.snp.leading)
//            $0.trailing.equalTo(menuWrapper.snp.trailing)
//            $0.height.equalTo(menuWrapper.snp.height)
//        }
//
//        oneLinerLabel.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.leading.equalToSuperview().inset(16)
//            $0.width.equalTo(80)
//            $0.height.equalTo(40)
//        }
//
//        oneLinerTextField.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.leading.equalTo(oneLinerLabel.snp.trailing).inset(16)
//            $0.trailing.equalToSuperview().inset(16)
//            $0.height.equalTo(oneLinerLabel)
//        }
//
//        typeWrapper.snp.makeConstraints {
//            $0.top.equalTo(oneLinerWrapper.snp.bottom).offset(24)
//            $0.leading.equalTo(oneLinerWrapper.snp.leading)
//            $0.trailing.equalTo(oneLinerWrapper.snp.trailing)
//            $0.height.equalTo(oneLinerWrapper.snp.height)
//        }
//
//        typeLabel.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.leading.equalToSuperview().inset(16)
//            $0.width.equalTo(80)
//            $0.height.equalTo(40)
//        }
//
//        typeStackView.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.leading.equalTo(restaurantNameLabel.snp.trailing).inset(16)
//            $0.trailing.equalToSuperview().inset(16)
//            $0.height.equalTo(typeLabel)
//        }
//
//        typeLikeButton.snp.makeConstraints {
//            $0.width.equalTo(44)
//        }
//
//        typeCuriousButton.snp.makeConstraints {
//            $0.width.equalTo(44)
//        }
//
//        typeWarningButton.snp.makeConstraints {
//            $0.width.equalTo(44)
//        }
//
//        doneButton.snp.makeConstraints {
//            $0.leading.trailing.equalToSuperview().inset(24)
//            $0.bottom.equalToSuperview().inset(24)
//            $0.height.equalTo(52)
//        }
//    }
//
//    // MARK: Methods
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == restaurantNameTextField {
//            menuTextField.becomeFirstResponder()
//        } else if textField == menuTextField {
//            oneLinerTextField.becomeFirstResponder()
//        } else {
//            oneLinerTextField.resignFirstResponder()
//        }
//        return true
//    }
//
//
//    // MARK: @objc
//    @objc func tappedLike(button: UIButton) {
//        selectedLike = !selectedLike
//
//        if selectedLike {
//            type = "like"
//            typeLikeButton.setImage(UIImage(named: "likeFill"), for: .normal)
//            typeCuriousButton.setImage(UIImage(named: "curious"), for: .normal)
//            typeWarningButton.setImage(UIImage(named: "warning"), for: .normal)
//        } else {
//            type = nil
//            typeLikeButton.setImage(UIImage(named: "like"), for: .normal)
//        }
//
//    }
//
//    @objc func tappedCurious(button: UIButton) {
//        selectedCurious = !selectedCurious
//
//        if selectedCurious {
//            type = "curious"
//            typeLikeButton.setImage(UIImage(named: "like"), for: .normal)
//            typeCuriousButton.setImage(UIImage(named: "curiousFill"), for: .normal)
//            typeWarningButton.setImage(UIImage(named: "warning"), for: .normal)
//        } else {
//            type = nil
//            typeCuriousButton.setImage(UIImage(named: "curious"), for: .normal)
//        }
//
//    }
//
//    @objc func tappedWarning(button: UIButton) {
//        selectedWarning = !selectedWarning
//
//        if selectedWarning {
//            type = "warning"
//            typeLikeButton.setImage(UIImage(named: "like"), for: .normal)
//            typeCuriousButton.setImage(UIImage(named: "curious"), for: .normal)
//            typeWarningButton.setImage(UIImage(named: "warningFill"), for: .normal)
//        } else {
//            type = nil
//            typeWarningButton.setImage(UIImage(named: "warning"), for: .normal)
//        }
//
//    }
//
//    @objc func doneTapped() {
//
//        if restaurantNameTextField.text == "" {
//            self.view.makeToast("맛집명을 입력 해주세요.", position: .top)
//            return
//        } else if menuTextField.text == "" {
//            self.view.makeToast("메뉴명을 입력 해주세요.", position: .top)
//            return
//        } else if oneLinerTextField.text == "" {
//            self.view.makeToast("한줄팁을 입력 해주세요.", position: .top)
//            return
//        }
//
//        guard let restaurantName = restaurantNameTextField.text else { return }
//        guard let menu = menuTextField.text else { return }
//        guard let oneLiner = oneLinerTextField.text else { return }
//        guard let type = self.type else {
//            self.view.makeToast("평가버튼을 눌러 주세요.", position: .top)
//            return }
//
//
//
//        let menusModel: [Menus] = [Menus(id: 1, // 최초 맛집 생성후 메뉴 추가니 id = 1
//                                         isFavorite: false,
//                                         menu: menu,
//                                         oneLiner: oneLiner,
//                                         type: type)]
//        let restaurantModel: [Restaurants] = [Restaurants(restaurantName: restaurantName,
//                                                          menu: menusModel)]
//
//        totalRestaurants.append(contentsOf: restaurantModel)
//
//        UserDefaultsManager.shared.saveRestaurants(restaurants: totalRestaurants)
//
//        delegate?.sendUpdate(foodsData: totalRestaurants)
//        dismiss(animated: true, completion: nil)
//    }
//
//    @objc func closeTapped() {
//        dismiss(animated: true, completion: nil)
//    }
//
////    @objc func keyboardWillShow(_ sender: Notification) {
////        self.view.frame.origin.y = -100 // view를 150만큼 위로 올림
////    }
////
////    @objc func keyboardWillHide(_ sender: Notification) {
////        self.view.frame.origin.y = 0
////    }
//}
