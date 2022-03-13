//
//  FoodDetailViewController.swift
//  Besteats
//
//  Created by BH on 2022/02/28.
//

import UIKit

import SnapKit

class FoodDetailTableViewCell: UITableViewCell {
    static let identifier = "FoodDetailTableViewCell"
    
    lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BM JUA_OTF", size: 30)
        label.text = "메뉴명"
        return label
    }()
    
//    lazy var favor
    
    lazy var oneLinerLabel: UILabel = {
        let label = UILabel()
        label.text = "∙ 소스에 찍먹"
        label.font = UIFont(name: "BM JUA_OTF", size: 20)
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
//        button.
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCell() {
        contentView.addSubview(menuLabel)
        contentView.addSubview(oneLinerLabel)
        
        menuLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(30)
        }
        
        oneLinerLabel.snp.makeConstraints {
            $0.leading.equalTo(menuLabel)
            $0.top.equalTo(menuLabel.snp.bottom).offset(30)
        }
    }
}

class FoodDetailViewController: UIViewController {
    
    // MARK: Properties
    
    var selectedLike = true
    var selectedCurious = false
    var selectedWarning = false
    var type: String = "like"
    
    lazy var typeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeTypeButton, curiousTypeButton, warningTypeButton])
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var likeTypeButton: UIButton = {
        let button = UIButton()
        button.setTitle("좋아요", for: .normal)
        button.titleLabel?.font = UIFont(name: "BM JUA_OTF", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedLikeButton), for: .touchUpInside)
        return button
    }()
    
    lazy var curiousTypeButton: UIButton = {
        let button = UIButton()
        button.setTitle("먹어볼래요", for: .normal)
        button.titleLabel?.font = UIFont(name: "BM JUA_OTF", size: 20)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedCuriousButton), for: .touchUpInside)
        return button
    }()
    
    lazy var warningTypeButton: UIButton = {
        let button = UIButton()
        button.setTitle("별로에요", for: .normal)
        button.titleLabel?.font = UIFont(name: "BM JUA_OTF", size: 20)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedWarningButton), for: .touchUpInside)
        return button
    }()
    
    lazy var foodDetailTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FoodDetailTableViewCell.self, forCellReuseIdentifier: FoodDetailTableViewCell.identifier)
        return tableView
    }()
    
    
    // MARK: LifeCycle
    
    override func loadView() {
        super.loadView()
        setUpTableView()
        foodDetailTableView.dataSource = self
        foodDetailTableView.delegate = self
        foodDetailTableView.rowHeight = 150
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addTapped))
        setUpUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpTableView()
    }
    
    // MARK: Methods
    
    private func setUpTableView() {
        
        view.addSubview(foodDetailTableView)
        foodDetailTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setUpUI() {
        
        view.addSubview(typeStackView)
        typeStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
//        likeTypeButton.snp.makeConstraints {
//            $0.width.equalTo(68)
//        }
//
//        curiousTypeButton.snp.makeConstraints {
//            $0.width.equalTo(68)
//        }
//
//        warningTypeButton.snp.makeConstraints {
//            $0.width.equalTo(68)
//        }
        
    }
    // MARK: @objc
    
    @objc func addTapped() {
        
        let foodModiVC = FoodModiViewController()
        present(foodModiVC, animated: true, completion: nil)
    }
    
    @objc func tappedLikeButton() {
        type = "like"
        
        if type == "like" {
            likeTypeButton.setTitleColor(.white, for: .normal)
            likeTypeButton.backgroundColor = .systemRed
            curiousTypeButton.setTitleColor(.black, for: .normal)
            curiousTypeButton.backgroundColor = .white
            warningTypeButton.setTitleColor(.black, for: .normal)
            warningTypeButton.backgroundColor = .white
        } else {
            likeTypeButton.setTitleColor(.black, for: .normal)
            likeTypeButton.backgroundColor = .white
        }
    }
    
    @objc func tappedCuriousButton() {
//        selectedCurious = !selectedCurious
        type = "curious"
        
        if type == "curious" {
            likeTypeButton.setTitleColor(.black, for: .normal)
            likeTypeButton.backgroundColor = .white
            curiousTypeButton.setTitleColor(.white, for: .normal)
            curiousTypeButton.backgroundColor = .systemRed
            warningTypeButton.setTitleColor(.black, for: .normal)
            warningTypeButton.backgroundColor = .white
        } else {
            curiousTypeButton.setTitleColor(.black, for: .normal)
            curiousTypeButton.backgroundColor = .white
        }
    }
    
    @objc func tappedWarningButton() {
//        selectedWarning = !selectedWarning
        type = "warning"
        
        if type == "warning" {
            likeTypeButton.setTitleColor(.black, for: .normal)
            likeTypeButton.backgroundColor = .white
            curiousTypeButton.setTitleColor(.black, for: .normal)
            curiousTypeButton.backgroundColor = .white
            warningTypeButton.setTitleColor(.white, for: .normal)
            warningTypeButton.backgroundColor = .systemRed
        } else {
            warningTypeButton.setTitleColor(.black, for: .normal)
            warningTypeButton.backgroundColor = .white
        }
    }
        
}

// MARK: Extension

extension FoodDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodDetailTableViewCell.identifier, for: indexPath)
        
        return cell
    }
    
    
}

extension FoodDetailViewController: UITableViewDelegate {
    
}

#if DEBUG

import SwiftUI
@available(iOS 13.0, *)

// UIViewControllerRepresentable을 채택
struct FoodDetailViewControllerRepresentable: UIViewControllerRepresentable {
    // update
    // _ uiViewController: UIViewController로 지정
    func updateUIViewController(_ uiViewController: UIViewController , context: Context) {
        
    }
    // makeui
    func makeUIViewController(context: Context) -> UIViewController {
    // Preview를 보고자 하는 Viewcontroller 이름
    // e.g.)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        return storyboard.instantiateViewController(withIdentifier: "FoodDetailViewController") as! FoodDetailViewController
//
        return FoodDetailViewController()
    }
}

struct FoodDetailViewController_Previews: PreviewProvider {
    
    @available(iOS 13.0, *)
    static var previews: some View {
        // UIViewControllerRepresentable에 지정된 이름.
        Group {
            FoodDetailViewControllerRepresentable()

    // 테스트 해보고자 하는 기기
                .previewDevice("iPhone 12")
            FoodDetailViewControllerRepresentable()
            
            // 테스트 해보고자 하는 기기
                .previewDevice("iPhone 12")
        }
    }
}
#endif
