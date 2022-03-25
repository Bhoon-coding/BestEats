//
//  FoodDetailViewController.swift
//  Besteats
//
//  Created by BH on 2022/02/28.
//

import UIKit
import SnapKit

class FoodDetailViewController: UIViewController {
    
    // MARK: Properties
    
    var selectedLike = true
    var selectedCurious = false
    var selectedWarning = false
    var type: String = "like"
    var totalRestaurants: [Restaurants] = []
    var selectedRestaurant: Restaurants
    var selectedIdx: Int
    
    
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
    
    lazy var foodDetailTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FoodDetailTableViewCell.self,
                           forCellReuseIdentifier: FoodDetailTableViewCell.identifier)
        return tableView
    }()
    
    
    // MARK: LifeCycle
    
    override func loadView() {
        super.loadView()
        
        selectedRestaurant = UserDefaultsManager.shared.getRestaurants()[selectedIdx]
        
        setUpTableView()
        foodDetailTableView.dataSource = self
        foodDetailTableView.delegate = self
        foodDetailTableView.rowHeight = 150
        
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
            self.foodDetailTableView.reloadData()
        }
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
    }
    
    private func updateTableData() {
           if let getFoodDatas = UserDefaults.standard.value(forKey: "foodDatas") as? Data {
               let foodDatas = try? PropertyListDecoder().decode([Restaurants].self, from: getFoodDatas)
               totalRestaurants = foodDatas ?? []
               
               DispatchQueue.main.async {
                   self.foodDetailTableView.reloadData()
               }
           }
       }
        
    
    // MARK: @objc
    
    @objc func addTapped() {
        
        let menuAddVC = MenuAddViewController(selectedRestaurant: selectedRestaurant, selectedIndex: selectedIdx
        )
        
        menuAddVC.modalPresentationStyle = .fullScreen
        present(menuAddVC, animated: true, completion: nil)
    }
    
    @objc func tappedLikeButton() {
        type = "like"
        
        DispatchQueue.main.async {
            self.foodDetailTableView.reloadData()
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
            self.foodDetailTableView.reloadData()
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
//        selectedWarning = !selectedWarning
        type = "warning"
        
        DispatchQueue.main.async {
            self.foodDetailTableView.reloadData()
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
        
//        UserDefaultsManager.shared.updateRestaurant(restaurant: selectedRestaurant, index: selectedIdx)
        
//        var typeLike = totalRestaurants[selectedIdx].menu.filter {
//            $0.type == "like"
//        }
//        var typeCurious = totalRestaurants[selectedIdx].menu.filter {
//            $0.type == "curious"
//        }
//        var typeWarning = totalRestaurants[selectedIdx].menu.filter {
//            $0.type == "warning"
//        }
//
//        let point = sender.convert(CGPoint.zero, to: foodDetailTableView)
//        guard let indexPath = foodDetailTableView.indexPathForRow(at: point) else { return }
//
//
//        if type == "like" {
//            print("삭제전: \(typeLike)")
////            typeLike.remove(at: indexPath.row)
//            let deletedMenu = totalRestaurants[selectedIdx].menu.filter { menu in
//                if menu == typeLike[indexPath.row] {
//                    print("menu:",menu)
//                    return true
//                } else {
//                    return false
//                }
//            }
//            guard let firstMenu = deletedMenu.first else { return }
//            var testIndex = totalRestaurants[selectedIdx].menu.firstIndex{$0 == firstMenu}
//
//            var test = Int(testIndex!)
//            totalRestaurants[selectedIdx].menu.remove(at: test)
//            foodDetailTableView.reloadData()
////            foodDetailTableView.deleteRows(at: [indexPath], with: .automatic)
//            print("삭제후: \(typeLike)")
//        } else if type == "curious" {
//            print("삭제전: \(typeCurious)")
//            typeCurious.remove(at: indexPath.row)
//            print("삭제후: \(typeCurious)")
//            foodDetailTableView.deleteRows(at: [indexPath], with: .automatic)
//        } else {
//            print("삭제전: \(typeWarning)")
//            typeWarning.remove(at: indexPath.row)
//            print("삭제후: \(typeWarning)")
//            foodDetailTableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//        totalRestaurants.remove(at: indexPath.row)
        
    }
        
}

// MARK: Extension

extension FoodDetailViewController: UITableViewDataSource {
    
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodDetailTableViewCell.identifier, for: indexPath) as! FoodDetailTableViewCell
        
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

extension FoodDetailViewController: UITableViewDelegate {
    
}

