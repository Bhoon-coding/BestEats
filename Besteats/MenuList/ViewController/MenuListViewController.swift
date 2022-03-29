//
//  menuListViewController.swift
//  Besteats
//
//  Created by BH on 2022/02/28.
//

import UIKit
import SnapKit

class MenuListViewController: UIViewController {
    
    // MARK: Properties
    
    var selectedLike = true
    var selectedCurious = false
    var selectedWarning = false
    var type: String = "like"
    var totalRestaurants: [Restaurants] = []
    var selectedRestaurant: Restaurants
    var selectedIdx: Int
    var totalMenus: [Menus] = []
    
    
    init(selectedRestaurant: Restaurants ,index: Int) {
        self.selectedRestaurant = selectedRestaurant
        self.selectedIdx = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var typeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeTypeButton,
                                                       curiousTypeButton,
                                                       warningTypeButton
                                                      ])
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
    
    lazy var menuListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MenuListTableViewCell.self,
                           forCellReuseIdentifier: MenuListTableViewCell.identifier)
        return tableView
    }()
    
    
    // MARK: LifeCycle
    
    override func loadView() {
        super.loadView()
        
        selectedRestaurant = UserDefaultsManager.shared.getRestaurants()[selectedIdx]
        
        setUpTableView()
        menuListTableView.dataSource = self
        menuListTableView.delegate = self
        menuListTableView.rowHeight = 150
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "BM JUA_OTF", size: 20)!]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addTapped))
        title = selectedRestaurant.restaurantName
        
        view.backgroundColor = .brown
        setUpUI()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedRestaurant = UserDefaultsManager.shared.getRestaurants()[selectedIdx]
        
        DispatchQueue.main.async {
            self.menuListTableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpTableView()
        
    }
    
    
    // MARK: Methods
    
    private func setUpTableView() {
        
        view.addSubview(menuListTableView)
        menuListTableView.snp.makeConstraints {
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
    }
    
    // MARK: @objc
    
    @objc func addTapped() {
        
        let menuAddVC = MenuAddViewController(selectedRestaurant: selectedRestaurant,
                                              selectedIndex: selectedIdx
        )
        
        menuAddVC.modalPresentationStyle = .fullScreen
        present(menuAddVC, animated: true, completion: nil)
    }
    
    @objc func tappedLikeButton() {
        type = "like"
        
        DispatchQueue.main.async {
            self.menuListTableView.reloadData()
        }
        
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
        
        DispatchQueue.main.async {
            self.menuListTableView.reloadData()
        }
        
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
        type = "warning"
        
        DispatchQueue.main.async {
            self.menuListTableView.reloadData()
        }
        
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
    
    @objc func deleteTapped(_ sender: UIButton) {
        
        let point = sender.convert(CGPoint.zero, to: menuListTableView)
        guard let indexPath = menuListTableView.indexPathForRow(at: point) else { return }
        
        // MARK: 타입 별로 나누기 위해 filter로 array 재정렬 및 타입별 array index를 파라미터로 보냄
        if type == "like" {
            let typeLike = selectedRestaurant.menu.filter { $0.type == "like" }
            selectedRestaurant = UserDefaultsManager.shared.deleteMenu(selectedRestaurant: selectedRestaurant,
                                                                     selectedIndex: selectedIdx,
                                                                       menu: typeLike[indexPath.row])
        } else if type == "curious" {
            let typeCurious = selectedRestaurant.menu.filter { $0.type == "curious" }
            selectedRestaurant = UserDefaultsManager.shared.deleteMenu(selectedRestaurant: selectedRestaurant,
                                                                     selectedIndex: selectedIdx,
                                                                       menu: typeCurious[indexPath.row])

        } else {
            let typeWarning = selectedRestaurant.menu.filter { $0.type == "warning" }
            selectedRestaurant = UserDefaultsManager.shared.deleteMenu(selectedRestaurant: selectedRestaurant,
                                                                     selectedIndex: selectedIdx,
                                                                       menu: typeWarning[indexPath.row])
        }
        
        menuListTableView.reloadData()
        
    }
        
}

// MARK: Extension

extension MenuListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let typeLike = selectedRestaurant.menu.filter {
            $0.type == "like"
        }
        let typeCurious = selectedRestaurant.menu.filter {
            $0.type == "curious"
        }
        let typeWarning = selectedRestaurant.menu.filter {
            $0.type == "warning"
        }
        
            if type == "like" {
                return typeLike.count
                
            } else if type == "curious" {
                return typeCurious.count
                
            } else {
                return typeWarning.count
                
            }
        
        }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuListTableViewCell.identifier, for: indexPath) as! MenuListTableViewCell
        
        let typeLike = selectedRestaurant.menu.filter {
            $0.type == "like"
        }
        let typeCurious = selectedRestaurant.menu.filter {
            $0.type == "curious"
        }
        let typeWarning = selectedRestaurant.menu.filter {
            $0.type == "warning"
        }
        
        if type == "like" {
            cell.menuLabel.text = typeLike[indexPath.row].menu
            cell.oneLinerLabel.text = typeLike[indexPath.row].oneLiner
            
        } else if type == "curious" {
            cell.menuLabel.text = typeCurious[indexPath.row].menu
            cell.oneLinerLabel.text = typeCurious[indexPath.row].oneLiner
            
        } else {
            cell.menuLabel.text = typeWarning[indexPath.row].menu
            cell.oneLinerLabel.text = typeWarning[indexPath.row].oneLiner
            
        }
        
        cell.deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        
        return cell
    }
    
}

extension MenuListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuDetailVC = MenuDetailViewController()
        navigationController?.pushViewController(menuDetailVC, animated: true)
    }
}

