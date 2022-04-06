//
//  menuListViewController.swift
//  Besteats
//
//  Created by BH on 2022/02/28.
//

import UIKit
import SnapKit


let checkedFavorite = UIImage(named: "starFill")
let uncheckedFavorite = UIImage(named: "star")

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
    var favoriteMenu: [String] = []
    
    
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
        button.backgroundColor = .systemGreen
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
        tableView.backgroundColor = .secondarySystemBackground
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
        
        // MARK: NavigationBar
        let mediumFontAttributes = [NSAttributedString.Key.font: UIFont(name: "BM JUA_OTF",
                                                                        size: 20)!]
        let smallFontAttributes = [NSAttributedString.Key.font: UIFont(name: "BM JUA_OTF",
                                                                       size: 16)!]
        // left
        self.navigationController?.navigationBar.titleTextAttributes = mediumFontAttributes
        // center
        title = selectedRestaurant.restaurantName
        // right
        let addButton = UIBarButtonItem(title: "추가",
                                        style: .plain,
                                        target: self,
                                        action: #selector(addTapped))
        
        addButton.setTitleTextAttributes(smallFontAttributes, for: .normal)
        navigationItem.rightBarButtonItem = addButton
        
        view.backgroundColor = .secondarySystemBackground
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
            likeTypeButton.backgroundColor = .systemGreen
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
        type = "curious"
        
        DispatchQueue.main.async {
            self.menuListTableView.reloadData()
        }
        
        if type == "curious" {
            likeTypeButton.setTitleColor(.black, for: .normal)
            likeTypeButton.backgroundColor = .white
            curiousTypeButton.setTitleColor(.white, for: .normal)
            curiousTypeButton.backgroundColor = .systemGreen
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
            warningTypeButton.backgroundColor = .systemGreen
        } else {
            warningTypeButton.setTitleColor(.black, for: .normal)
            warningTypeButton.backgroundColor = .white
        }
    }
    
    @objc func tappedFavorite(_ sender: UIButton) {
        let typeLike = selectedRestaurant.menu.filter {
            $0.type == "like"
        }
        let indexPath = sender.tag
        let selectedItem = typeLike[indexPath]
        
        selectedRestaurant = UserDefaultsManager.shared.updateMenus(selectedRestaurant: selectedRestaurant,
                                               selectedIndex: selectedIdx,
                                               selectedMenu: selectedItem,
                                               menuIndex: indexPath)
        
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
            if typeLike.count == 0 {
                tableView.setEmptyMessage("맛있었던 메뉴를 \n\n추가해 주세요.")
            } else {
                tableView.restore()
            }
            return typeLike.count
            
        } else if type == "curious" {
            if typeCurious.count == 0 {
                tableView.setEmptyMessage("다음에 먹어보고 싶었던 메뉴를 \n\n추가해 주세요.")
            } else {
                tableView.restore()
            }
            return typeCurious.count
            
        } else {
            if typeWarning.count == 0 {
                tableView.setEmptyMessage("나와 안맞았던 메뉴를 \n\n추가해 주세요.")
            } else {
                tableView.restore()
            }
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
            
            let selectedItem = typeLike[indexPath.row]
            cell.menuLabel.text = selectedItem.menu
            cell.oneLinerLabel.text = selectedItem.oneLiner
            cell.favoriteButton.tag = indexPath.row
            cell.favoriteButton.addTarget(self, action: #selector(tappedFavorite), for: .touchUpInside)
            cell.favoriteButton.isHidden = false
                

            DispatchQueue.main.async {
                selectedItem.isFavorite
                ? cell.favoriteButton.setImage(checkedFavorite, for: .normal)
                : cell.favoriteButton.setImage(uncheckedFavorite, for: .normal)
                
            }

            
            }
        
        else if type == "curious" {
            cell.menuLabel.text = typeCurious[indexPath.row].menu
            cell.oneLinerLabel.text = typeCurious[indexPath.row].oneLiner
            cell.favoriteButton.isHidden = true
            
        } else if type == "warning" {
            cell.menuLabel.text = typeWarning[indexPath.row].menu
            cell.oneLinerLabel.text = typeWarning[indexPath.row].oneLiner
            cell.favoriteButton.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            
            if type == "like" {
                let typeLike = selectedRestaurant.menu.filter { $0.type == "like" }
                selectedRestaurant = UserDefaultsManager.shared.deleteMenu(selectedRestaurant: selectedRestaurant,
                                                                           selectedIndex: selectedIdx,
                                                                           menu: typeLike[indexPath.row],
                                                                           menuIndex: indexPath.row)
                menuListTableView.deleteRows(at: [indexPath], with: .left)
            } else if type == "curious" {
                let typeCurious = selectedRestaurant.menu.filter { $0.type == "curious" }
                selectedRestaurant = UserDefaultsManager.shared.deleteMenu(selectedRestaurant: selectedRestaurant,
                                                                           selectedIndex: selectedIdx,
                                                                           menu: typeCurious[indexPath.row],
                                                                           menuIndex: indexPath.row)
                menuListTableView.deleteRows(at: [indexPath], with: .left)
                
            } else {
                let typeWarning = selectedRestaurant.menu.filter { $0.type == "warning" }
                selectedRestaurant = UserDefaultsManager.shared.deleteMenu(selectedRestaurant: selectedRestaurant,
                                                                           selectedIndex: selectedIdx,
                                                                           menu: typeWarning[indexPath.row],
                                                                           menuIndex: indexPath.row)
                menuListTableView.deleteRows(at: [indexPath], with: .left)
            }
            
            menuListTableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "삭제"
    }
    
}

extension MenuListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuDetailVC = MenuDetailViewController()
        navigationController?.pushViewController(menuDetailVC, animated: true)
    }
}

