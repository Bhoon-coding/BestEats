//
//  FoodModiViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/30.
//

import UIKit

import SnapKit
import Toast_Swift

class FoodModiViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    // 변수추가시 preview 에러
    
    var selectedLike: Bool = false
    var selectedCurious: Bool = false
    var selectedWarning: Bool = false
    var type: String? = nil
    
    var foodDataBag: [FoodModiModel] = []
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var restaurantNameWrapper: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 3
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09988100166)
        return view
    }()
    
    lazy var restaurantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "맛집명:"
        return label
    }()
    
    lazy var restaurantNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "맛집 이름을 입력 해주세요."
        textField.layer.cornerRadius = 10
        textField.returnKeyType = .next
        textField.paddingLeft()
        return textField
    }()
    
    lazy var menuWrapper: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 3
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09988100166)
        return view
    }()
    
    lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.text = "메뉴명:"
        return label
    }()
    
    lazy var menuTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "메뉴 이름을 입력 해주세요."
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.returnKeyType = .next
        textField.paddingLeft()
        return textField
    }()
    
    lazy var oneLinerWrapper: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 3
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09988100166)
        return view
    }()
    
    lazy var oneLinerLabel: UILabel = {
        let label = UILabel()
        label.text = "한줄팁:"
        return label
    }()
    
    lazy var oneLinerTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "꿀팁을 입력 해주세요."
        textField.layer.cornerRadius = 10
        textField.returnKeyType = .done
        textField.paddingLeft()
        textField.text = nil
        return textField
    }()
    
    lazy var typeWrapper: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 3
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09988100166)
        return view
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = "내 평가:"
        return label
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
        button.setTitle("완료", for: .normal)
        button.tintColor = .label
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let foodDatas = UserDefaults.standard.value(forKey: "foodDatas") as? Data {
            let getFoodDatas = try? PropertyListDecoder().decode([FoodModiModel].self, from: foodDatas)
        
            foodDataBag.append(contentsOf: getFoodDatas ?? [])
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        restaurantNameTextField.delegate = self
        menuTextField.delegate = self
        oneLinerTextField.delegate = self

        // 키보드 크기 따라 View 위로 올리기
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setUpUI()
        
//      네비게이션 push로 할시 주석 풀기. (현재 modal형식)
        
//        navigationController?.navigationBar.tintColor = .darkGray
//        navigationController?.navigationBar.topItem?.title = ""
//        navigationItem.backButtonTitle = ""
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneTapped))
//        navigationItem.title = "맛집 기록소"
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUpUI() {
        
        
        view.addSubview(closeButton)
        
        view.addSubview(restaurantNameWrapper)
        restaurantNameWrapper.addSubview(restaurantNameLabel)
        restaurantNameWrapper.addSubview(restaurantNameTextField)
        
        view.addSubview(menuWrapper)
        menuWrapper.addSubview(menuLabel)
        menuWrapper.addSubview(menuTextField)
        
        view.addSubview(oneLinerWrapper)
        oneLinerWrapper.addSubview(oneLinerLabel)
        oneLinerWrapper.addSubview(oneLinerTextField)
        
        view.addSubview(typeWrapper)
        typeWrapper.addSubview(typeLabel)
        typeWrapper.addSubview(typeStackView)
        typeStackView.addArrangedSubview(typeLikeButton)
        typeStackView.addArrangedSubview(typeCuriousButton)
        typeStackView.addArrangedSubview(typeWarningButton)
        
        view.addSubview(doneButton)
        
        closeButton.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(24)
            $0.size.equalTo(20)
        }
        
        restaurantNameWrapper.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.top).inset(64)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(100)
        }
        
        restaurantNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }

        restaurantNameTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(restaurantNameLabel.snp.trailing).inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(restaurantNameLabel)
        }
        
        menuWrapper.snp.makeConstraints {
            $0.top.equalTo(restaurantNameWrapper.snp.bottom).offset(24)
            $0.leading.equalTo(restaurantNameWrapper.snp.leading)
            $0.trailing.equalTo(restaurantNameWrapper.snp.trailing)
            $0.height.equalTo(restaurantNameWrapper.snp.height)
        }
        
        menuLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        menuTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(menuLabel.snp.trailing).inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(menuLabel)
        }
        
        oneLinerWrapper.snp.makeConstraints {
            $0.top.equalTo(menuWrapper.snp.bottom).offset(24)
            $0.leading.equalTo(menuWrapper.snp.leading)
            $0.trailing.equalTo(menuWrapper.snp.trailing)
            $0.height.equalTo(menuWrapper.snp.height)
        }
        
        oneLinerLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        oneLinerTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(oneLinerLabel.snp.trailing).inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(oneLinerLabel)
        }
        
        typeWrapper.snp.makeConstraints {
            $0.top.equalTo(oneLinerWrapper.snp.bottom).offset(24)
            $0.leading.equalTo(oneLinerWrapper.snp.leading)
            $0.trailing.equalTo(oneLinerWrapper.snp.trailing)
            $0.height.equalTo(oneLinerWrapper.snp.height)
        }
        
        typeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        typeStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(restaurantNameLabel.snp.trailing).inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(typeLabel)
        }
        
        typeLikeButton.snp.makeConstraints {
            $0.width.equalTo(44)
        }

        typeCuriousButton.snp.makeConstraints {
            $0.width.equalTo(44)
        }

        typeWarningButton.snp.makeConstraints {
            $0.width.equalTo(44)
        }
        
        doneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
    
    // MARK: Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == restaurantNameTextField {
            menuTextField.becomeFirstResponder()
        } else if textField == menuTextField {
            oneLinerTextField.becomeFirstResponder()
        } else {
            oneLinerTextField.resignFirstResponder()
        }
        return true
    }
    
    
    // MARK: @objc
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
        
        if restaurantNameTextField.text == "" {
            self.view.makeToast("맛집명을 입력 해주세요.", position: .top)
            return
        } else if menuTextField.text == "" {
            self.view.makeToast("메뉴명을 입력 해주세요.", position: .top)
            return
        } else if oneLinerTextField.text == "" {
            self.view.makeToast("한줄팁을 입력 해주세요.", position: .top)
            return
        }

        guard let restaurantName = restaurantNameTextField.text else { return }
        guard let menu = menuTextField.text else { return }
        guard let oneLiner = oneLinerTextField.text else { return }
        guard let type = self.type else {
            self.view.makeToast("평가버튼을 눌러 주세요.", position: .top)
            return }
        
        let foodModiData: [FoodModiModel] = [
            FoodModiModel(restaurantName: restaurantName,
                          menu: menu,
                          oneLiner: oneLiner,
                          type: type)
        ]
        
        foodDataBag.append(contentsOf: foodModiData)
        print("foodDataBag:", foodDataBag)
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(foodDataBag), forKey: "foodDatas")
        
        dismiss(animated: true, completion: nil)
//        navigationController?.popViewController(animated: true)
    }
    
    @objc func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
    
//    @objc func keyboardWillShow(_ sender: Notification) {
//        self.view.frame.origin.y = -100 // view를 150만큼 위로 올림
//    }
//
//    @objc func keyboardWillHide(_ sender: Notification) {
//        self.view.frame.origin.y = 0
//    }
}

#if DEBUG

import SwiftUI
@available(iOS 13.0, *)

// UIViewControllerRepresentable을 채택
struct FoodModiViewControllerRepresentable: UIViewControllerRepresentable {
    // update
    // _ uiViewController: UIViewController로 지정
    func updateUIViewController(_ uiViewController: UIViewController , context: Context) {
        
    }
    // makeui
    func makeUIViewController(context: Context) -> UIViewController {
    // Preview를 보고자 하는 Viewcontroller 이름
    // e.g.)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        return storyboard.instantiateViewController(withIdentifier: "FoodModiViewController") as! FoodModiViewController
//
        return FoodModiViewController()
    }
}

struct FoodModiViewController_Previews: PreviewProvider {
    
    @available(iOS 13.0, *)
    static var previews: some View {
        // UIViewControllerRepresentable에 지정된 이름.
        FoodModiViewControllerRepresentable()

// 테스트 해보고자 하는 기기
            .previewDevice("iPhone 12")
    }
}
#endif
