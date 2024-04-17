//
//  ViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/11.
//

import UIKit

final class RestaurantViewController: UIViewController {
    
    private enum Alert {
        enum Contents {
            static let actionSheetTitle: String = "맛집명 변경, 삭제"
            static let actionSheetMessage: String = "아래 항목을 선택해 주세요."
            static let editTitle: String = "맛집명 변경"
            static let editMessage: String = "변경할 맛집의 이름을 입력해주세요."
            static let deleteTitle: String = "해당 맛집에 포함된 메뉴들도 삭제 됩니다."
            static let deleteMessage: String = "정말로 삭제 하시겠습니까?"
        }
        enum Button {
            static let restaurantEdit: String = "맛집명 변경"
            static let restaurantDelete: String = "맛집 삭제"
            static let cancel: String = "취소"
            static let edit: String = "변경"
            static let delete: String = "삭제"
        }
    }
    
    private enum Navigation {
        enum Button {
            static let add: String = "추가"
        }
    }
    
    @IBOutlet weak var foodSearchBar: UISearchBar!
    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    private var totalRestaurants: [Restaurant] = []
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureKeyboardDismiss()
        configureNavBar()
        configureUI()
        configureDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        getRestaurantsData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        foodSearchBar.resignFirstResponder()
    }
    
    // MARK: Action
    
    @IBAction private func tapMore(_ sender: UIButton) {
//        
//        let point = sender.convert(CGPoint.zero, to: foodCollectionView)
//        guard let indexPath = foodCollectionView.indexPathForItem(at: point) else { return }
//        
//        DispatchQueue.main.async {
//            
//            // MARK: ActionSheet
//            let actionSheet = UIAlertController(title: Alert.Contents.actionSheetTitle,
//                                                message: Alert.Contents.actionSheetMessage,        preferredStyle: .actionSheet)
//            
//            let cancelButton = UIAlertAction(title: Alert.Button.cancel,
//                                       style: .cancel,
//                                       handler: nil)
//            let editRestaurant = UIAlertAction(title: Alert.Button.restaurantEdit,
//                                               style: .default) {_ in
//                
//                let editAlert = UIAlertController(title: Alert.Contents.editTitle,
//                                                  message: Alert.Contents.editMessage,
//                                                  preferredStyle: .alert)
//                
//                let editButton = UIAlertAction(title: Alert.Button.edit,
//                                               style: .default) {_ in
//                    if let txtField = editAlert.textFields?.first,
//                       let text = txtField.text {
////                        self.totalRestaurants[indexPath.row].restaurantName = text
//                        
//                        UserDefaultsManager.shared.saveRestaurants(restaurants: self.totalRestaurants)
//                        
//                        self.foodCollectionView.reloadData()
//                    }
//                }
//                editAlert.addTextField { textField in
//                    textField.placeholder = "\(self.totalRestaurants[indexPath.row].restaurantName)"
//                }
//                editAlert.addAction(editButton)
//                editAlert.addAction(cancelButton)
//                
//                self.present(editAlert, animated: true, completion: nil)
//            }
//            
//            let tappedDelete = UIAlertAction(title: Alert.Button.restaurantDelete,
//                                             style: .destructive) {_ in
//                
//                let deleteConfirmAlert = UIAlertController(title: Alert.Contents.deleteTitle,
//                                                           message: Alert.Contents.deleteMessage,
//                                                           preferredStyle: .alert)
//                
//                let deleteRestaurant = UIAlertAction(title: Alert.Button.delete,
//                                                     style: .destructive) {_ in
//                    
//                    self.totalRestaurants.remove(at: indexPath.row)
//                    
//                    UserDefaultsManager.shared.saveRestaurants(restaurants: self.totalRestaurants)
//                    
//                    self.foodCollectionView.reloadData()
//                    
//                }
//                
//                deleteConfirmAlert.addAction(deleteRestaurant)
//                deleteConfirmAlert.addAction(cancelButton)
//                self.present(deleteConfirmAlert, animated: true, completion: nil)
//            }
//            
//            actionSheet.addAction(editRestaurant)
//            actionSheet.addAction(tappedDelete)
//            actionSheet.addAction(cancelButton)
//            
//            self.present(actionSheet, animated: true, completion: nil)
//            
//        }
    }

    // MARK: Methods
    
    private func getRestaurantsData() {
        totalRestaurants = CoreDataManager.shared.fetchRestaurant()
        DispatchQueue.main.async {
            self.foodCollectionView.reloadData()
        }
    }
    
    private func configureNavBar() {
        let addButton = UIBarButtonItem(
            title: Navigation.Button.add,
            style: .plain,
            target: self, action: #selector(presentRestaurantAddVC)
        )
        addButton.setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont(name: Fonts.bold, size: 14)!],
            for: .normal
        )
        navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.tintColor = .label
        
        let backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self, action: nil
        )
        
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    private func configureDelegate() {
        foodSearchBar.delegate = self
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
    }
    
    private func configureKeyboardDismiss() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        foodCollectionView.addGestureRecognizer(tap)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        foodSearchBar.resignFirstResponder()
    }
    
    
    // MARK: @objc
    
    @objc func presentRestaurantAddVC() {
        let restaurantAddVC = RestaurantAddViewController()
        restaurantAddVC.modalPresentationStyle = .fullScreen
        present(restaurantAddVC, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        foodSearchBar.resignFirstResponder()
    }
    
    
}

class FoodCollectionViewCell: UICollectionViewCell {
    
    // MARK: Cell Outlet
    @IBOutlet weak var restaurantNamesLabel: UILabel!
    @IBOutlet weak var favoriteMenuLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var curiousCountLabel: UILabel!
    @IBOutlet weak var warningCountLabel: UILabel!
}

extension RestaurantViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        totalRestaurants = searchText.isEmpty
        ? UserDefaultsManager.shared.getRestaurants()
        : UserDefaultsManager.shared.getRestaurants().filter { $0.restaurantName.contains(searchText) || $0.restaurantName.lowercased().contains(searchText.lowercased())}
         
        foodCollectionView.reloadData()
  }
}

// Cell layout
extension RestaurantViewController: UICollectionViewDelegateFlowLayout {
    // 위 아래 간격
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    // 좌우 간격
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Cell 사이즈
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = CGSize(width: view.frame.width - 80, height: 150)
        return size
    }
}

// Cell에 대한 delegate
extension RestaurantViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as? FoodCollectionViewCell else { return FoodCollectionViewCell() }
        let restaurant: Restaurant = totalRestaurants[indexPath.item]
        // TODO: [] 레스토랑이 있고 메뉴가 없는경우도 확인해보기 (메뉴삭제시 확인해볼것)
        let menus = restaurant.menus?.allObjects as! [Menu]
        let favoriteMenus = menus.filter { $0.isFavorite }
        let favoriteMenuString = setFavoriteMenuString(menus: favoriteMenus)
        
        // TODO: [] Cell Class 분리
        cell.restaurantNamesLabel.text = restaurant.name
        cell.favoriteMenuLabel.text = favoriteMenuString
        cell.likeCountLabel.text = "\(String(describing: menus.filter { $0.type == RatingType.like.rawValue }.count))"
        cell.curiousCountLabel.text = "\(String(describing: menus.filter { $0.type == RatingType.curious.rawValue }.count))"
        cell.warningCountLabel.text = "\(String(describing: menus.filter { $0.type == RatingType.bad.rawValue }.count))"
        
        return cell
    }
    
    // numberOfItemsInSection: Cell을 몇개 보여줄지
    public func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if totalRestaurants.count == 0 {
            collectionView.setEmptyMessage("맛집이 없어요.\n\n우측 상단 '추가' 버튼을 눌러 맛집을 추가해주세요.")
        } else {
            collectionView.restore()
        }
        return totalRestaurants.count
    }
    
    //
    public func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let menuListVC = MenuListViewController(selectedRestaurant: totalRestaurants[indexPath.row], index: indexPath.row)
        
        navigationController?.pushViewController(menuListVC,
                                                 animated: true)
        
        foodSearchBar.resignFirstResponder()
        foodSearchBar.text = ""
    }
    
    private func setFavoriteMenuString(menus: [Menu]?) -> String {
        guard let menus = menus else { return "" }
        var menuString = ""
        
        if menus.isEmpty {
            menuString = "즐겨찾는 메뉴를 추가해 주세요."
        } else if menus.count == 1 {
            menuString = menus[0].name ?? ""
        } else {
            menuString = "\(menus[0]) 외 ⭐️ \(menus.count - 1 )개"
        }
        
        return menuString
    }
}

// MARK: - Extension

extension RestaurantViewController {
    
    private func configureUI() {
        view.backgroundColor = .secondarySystemBackground
        foodCollectionView.backgroundColor = .secondarySystemBackground
    }
}
