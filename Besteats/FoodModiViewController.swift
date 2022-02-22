//
//  FoodModiViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/30.
//

import UIKit
import SnapKit

class FoodModiViewController: UIViewController, UITextFieldDelegate {
    
    // 변수추가시 preview 에러
    var selectedLike: Bool = false
    var selectedCurious: Bool = false
    var selectedWarning: Bool = false
    
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
        return textField
    }()
    
    lazy var rateWrapper: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 3
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09988100166)
        return view
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.text = "내 평가:"
        return label
    }()
    
    lazy var rateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var rateLikeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "like"), for: .normal)
        button.addTarget(self, action: #selector(tappedLike(button:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var rateCuriousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "curious"), for: .normal)
        button.addTarget(self, action: #selector(tappedCurious(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rateWarningButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "warning"), for: .normal)
        button.addTarget(self, action: #selector(tappedWarning(button:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantNameTextField.delegate = self
        menuTextField.delegate = self
        oneLinerTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setUpUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneTapped))
        navigationItem.backButtonTitle = ""
        navigationItem.title = "맛집 기록소"
        
    }
    
    @objc func doneTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUpUI() {
        // MARK: addSubView
        
        view.addSubview(restaurantNameWrapper)
        restaurantNameWrapper.addSubview(restaurantNameLabel)
        restaurantNameWrapper.addSubview(restaurantNameTextField)
        
        view.addSubview(menuWrapper)
        menuWrapper.addSubview(menuLabel)
        menuWrapper.addSubview(menuTextField)
        
        view.addSubview(oneLinerWrapper)
        oneLinerWrapper.addSubview(oneLinerLabel)
        oneLinerWrapper.addSubview(oneLinerTextField)
        
        view.addSubview(rateWrapper)
        rateWrapper.addSubview(rateLabel)
        rateWrapper.addSubview(rateStackView)
        rateStackView.addArrangedSubview(rateLikeButton)
        rateStackView.addArrangedSubview(rateCuriousButton)
        rateStackView.addArrangedSubview(rateWarningButton)
        
        // MARK: Layout
        restaurantNameWrapper.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(50)
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
        
        rateWrapper.snp.makeConstraints {
            $0.top.equalTo(oneLinerWrapper.snp.bottom).offset(24)
            $0.leading.equalTo(oneLinerWrapper.snp.leading)
            $0.trailing.equalTo(oneLinerWrapper.snp.trailing)
            $0.height.equalTo(oneLinerWrapper.snp.height)
        }
        
        rateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        rateStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(restaurantNameLabel.snp.trailing).inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(rateLabel)
        }
        
        rateLikeButton.snp.makeConstraints {
            $0.width.equalTo(44)
        }

        rateCuriousButton.snp.makeConstraints {
            $0.width.equalTo(44)
        }

        rateWarningButton.snp.makeConstraints {
            $0.width.equalTo(44)
        }
    }
    
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
    
    @objc func tappedLike(button: UIButton) {
        selectedLike = !selectedLike

        selectedLike
        ? button.setImage(UIImage(named: "likeFill"), for: .normal)
        : button.setImage(UIImage(named: "like"), for: .normal)
    }

    @objc func tappedCurious(button: UIButton) {
        selectedCurious = !selectedCurious

        selectedCurious
        ? button.setImage(UIImage(named: "curiousFill"), for: .normal)
        : button.setImage(UIImage(named: "curious"), for: .normal)
    }

    @objc func tappedWarning(button: UIButton) {
        selectedWarning = !selectedWarning

        selectedWarning
        ? button.setImage(UIImage(named: "warningFill"), for: .normal)
        : button.setImage(UIImage(named: "warning"), for: .normal)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -100 // view를 150만큼 위로 올림
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}

extension UITextField {
    func paddingLeft() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
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
