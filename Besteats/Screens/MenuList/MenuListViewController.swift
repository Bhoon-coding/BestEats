//
//  menuListViewController.swift
//  Besteats
//
//  Created by BH on 2022/02/28.
//

import UIKit
import SnapKit

private let uncheckedFavorite = UIImage(named: Image.star)
private let checkedFavorite = UIImage(named: Image.starFill)

final class MenuListViewController: UIViewController {
    
    // MARK: - Enums
    
    private enum RatingType {
        static let like: String = "like"
        static let curious: String = "curious"
        static let warning: String = "warning"
        
        enum Button {
            static let likeTitle: String = "좋아요"
            static let curiousTitle: String = "먹어볼래요"
            static let warningTitle: String = "별로에요"
        }
        enum EmptyState {
            static let likeMessage: String = "맛있었던 메뉴를 \n\n추가해 주세요."
            static let curiousMessage: String = "다음에 먹어보고 싶었던 메뉴를 \n\n추가해 주세요."
            static let warningMessage: String = "나와 안맞았던 메뉴를 \n\n추가해 주세요."
        }
    }
    
    private enum Navigation {
        enum Button {
            static let add: String = "추가"
        }
    }
    
    // MARK: - Properties
    
    private var selectedLike = true
    private var selectedCurious = false
    private var selectedWarning = false

    private var type = RatingType.like
    private var totalRestaurants: [Restaurant] = []
    private var selectedRestaurant: Restaurant
    private var selectedRestaurantIndex: Int
    private var totalMenus: [Menu] = []
    
    
    init(selectedRestaurant: Restaurant ,index: Int) {
        self.selectedRestaurant = selectedRestaurant
        self.selectedRestaurantIndex = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var typeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeTypeButton,
                                                       curiousTypeButton,
                                                       warningTypeButton
                                                      ])
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var likeTypeButton: UIButton = {
        let button = UIButton()
        button.setTitle(RatingType.Button.likeTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.bold, size: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedLikeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var curiousTypeButton: UIButton = {
        let button = UIButton()
        button.setTitle(RatingType.Button.curiousTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.bold, size: 16)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedCuriousButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var warningTypeButton: UIButton = {
        let button = UIButton()
        button.setTitle(RatingType.Button.warningTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.bold, size: 16)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedWarningButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var menuListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MenuListTableViewCell.self,
                           forCellReuseIdentifier: MenuListTableViewCell.identifier)
        tableView.backgroundColor = .secondarySystemBackground
        return tableView
    }()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpUI()
        setUpTableView()
        
        selectedRestaurant = UserDefaultsManager.shared.getRestaurants()[selectedRestaurantIndex]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedRestaurant = UserDefaultsManager.shared.getRestaurants()[selectedRestaurantIndex]
        
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
        
        setUpDelegate()
        menuListTableView.rowHeight = 150
        view.addSubview(menuListTableView)
        menuListTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setUpDelegate() {
        
        menuListTableView.dataSource = self
        menuListTableView.delegate = self
    }
    
    private func setUpNavigationBar() {
        let smallFontAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.bold,
                                                                       size: 14)!]
        let boldFontAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        let addButton = UIBarButtonItem(title: Navigation.Button.add,
                                        style: .plain,
                                        target: self,
                                        action: #selector(addTapped))
        navigationController?.navigationBar.titleTextAttributes = boldFontAttributes
        title = selectedRestaurant.restaurantName
        
        addButton.setTitleTextAttributes(smallFontAttributes, for: .normal)
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setUpUI() {
        
        view.backgroundColor = .secondarySystemBackground
        
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
                                              selectedIndex: selectedRestaurantIndex
        )
        
        menuAddVC.modalPresentationStyle = .fullScreen
        present(menuAddVC, animated: true, completion: nil)
    }
    
    @objc func tappedLikeButton() {
        type = RatingType.like
        
        DispatchQueue.main.async {
            self.menuListTableView.reloadData()
        }
        
        if type == RatingType.like {
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
        type = RatingType.curious
        
        DispatchQueue.main.async {
            self.menuListTableView.reloadData()
        }
        
        if type == RatingType.curious {
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
        type = RatingType.warning
        
        DispatchQueue.main.async {
            self.menuListTableView.reloadData()
        }
        
        if type == RatingType.warning {
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
        let index = sender.tag
        let selectedItem = selectedRestaurant.likeMenus[index]
        
        selectedRestaurant = UserDefaultsManager.shared.updateFavoriteMenu(
            selectedRestaurant: selectedRestaurant,
            selectedRestauransIndex: selectedRestaurantIndex,
            selectedMenu: selectedItem,
            menuIndex: index
        )
        
        menuListTableView.reloadData()
    }
}

// MARK: Extension

extension MenuListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if type == RatingType.like {
            selectedRestaurant.likeMenus.count == 0
            ? tableView.setEmptyMessage(RatingType.EmptyState.likeMessage)
            : tableView.restore()
            return selectedRestaurant.likeMenus.count
            
        } else if type == RatingType.curious {
            selectedRestaurant.curiousMenus.count == 0
            ? tableView.setEmptyMessage(RatingType.EmptyState.curiousMessage)
            : tableView.restore()
            return selectedRestaurant.curiousMenus.count
            
        } else {
            selectedRestaurant.badMenus.count == 0
            ? tableView.setEmptyMessage(RatingType.EmptyState.warningMessage)
            : tableView.restore()
            return selectedRestaurant.badMenus.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuListTableViewCell.identifier,
                                                 for: indexPath) as! MenuListTableViewCell
        
        if type == RatingType.like {
            let selectedItem = selectedRestaurant.likeMenus[indexPath.row]
            cell.menuLabel.text = selectedItem.menu
            cell.oneLinerLabel.text = selectedItem.oneLiner
            cell.favoriteButton.tag = indexPath.row
            cell.favoriteButton.addTarget(self,
                                          action: #selector(tappedFavorite),
                                          for: .touchUpInside)
            cell.favoriteButton.isHidden = false
                
            DispatchQueue.main.async {
                selectedItem.isFavorite
                ? cell.favoriteButton.setImage(checkedFavorite,
                                               for: .normal)
                : cell.favoriteButton.setImage(uncheckedFavorite,
                                               for: .normal)
            }
        } else if type == RatingType.curious {
            cell.menuLabel.text = selectedRestaurant.curiousMenus[indexPath.row].menu
            cell.oneLinerLabel.text = selectedRestaurant.curiousMenus[indexPath.row].oneLiner
            cell.favoriteButton.isHidden = true
            
        } else {
            cell.menuLabel.text = selectedRestaurant.badMenus[indexPath.row].menu
            cell.oneLinerLabel.text = selectedRestaurant.badMenus[indexPath.row].oneLiner
            cell.favoriteButton.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if type == RatingType.like {
                selectedRestaurant = UserDefaultsManager.shared.deleteMenu(
                    selectedRestaurant: selectedRestaurant,
                    selectedIndex: selectedRestaurantIndex,
                    type: type,
                    menu: selectedRestaurant.likeMenus[indexPath.row],
                    menuIndex: indexPath.row)
                menuListTableView.deleteRows(at: [indexPath], with: .left)
                
            } else if type == RatingType.curious {
                selectedRestaurant = UserDefaultsManager.shared.deleteMenu(
                    selectedRestaurant: selectedRestaurant,
                    selectedIndex: selectedRestaurantIndex,
                    type: type,
                    menu: selectedRestaurant.curiousMenus[indexPath.row],
                    menuIndex: indexPath.row
                )
                menuListTableView.deleteRows(at: [indexPath], with: .left)
                
            } else {
                selectedRestaurant = UserDefaultsManager.shared.deleteMenu(
                    selectedRestaurant: selectedRestaurant,
                    selectedIndex: selectedRestaurantIndex,
                    type: type,
                    menu: selectedRestaurant.badMenus[indexPath.row],
                    menuIndex: indexPath.row
                )
                menuListTableView.deleteRows(at: [indexPath], with: .left)
            }
            
            menuListTableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView,
                   titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? { return "삭제" }
    
}

extension MenuListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedMenu: Menu
        
        switch type {
        case RatingType.like:
            selectedMenu = selectedRestaurant.likeMenus[indexPath.row]
            
        case RatingType.curious:
            selectedMenu = selectedRestaurant.curiousMenus[indexPath.row]
            
        default:
            selectedMenu = selectedRestaurant.badMenus[indexPath.row]
        }
        
        let backBarButtonItem = UIBarButtonItem(title: "",
                                                style: .plain,
                                                target: self,
                                                action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        let menuDetailVC = MenuDetailViewController(
            selectedRestaurant: selectedRestaurant,
            selectedRestaurantIndex: selectedRestaurantIndex,
            selectedMenu: selectedMenu,
            selectedMenuIndex: indexPath.row,
            prevType: type
        )
        navigationController?.pushViewController(menuDetailVC, animated: true)
        
    }
}

