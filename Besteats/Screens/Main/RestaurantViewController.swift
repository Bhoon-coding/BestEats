//
//  ViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/11.
//

import UIKit

class RestaurantViewController: UIViewController {

    @IBOutlet weak var foodSearchBar: UISearchBar!
    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    var totalRestaurants: [Restaurant] = []
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalRestaurants = UserDefaultsManager.shared.getRestaurants()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        foodCollectionView.addGestureRecognizer(tap)
        
        foodSearchBar.delegate = self
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        
        view.backgroundColor = .secondarySystemBackground
        foodCollectionView.backgroundColor = .secondarySystemBackground
                
        navigationController?.navigationBar.tintColor = .label
        
        let addButton = UIBarButtonItem(title: "추가",
                                        style: .plain,
                                        target: self, action: #selector(addRestaurant))
        addButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "GmarketSansBold", size: 14)!], for: .normal)
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        totalRestaurants = UserDefaultsManager.shared.getRestaurants()
        
        DispatchQueue.main.async {
            self.foodCollectionView.reloadData()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        foodSearchBar.resignFirstResponder()
    }
    
    // MARK: 보류
    @IBAction func tapMore(_ sender: UIButton) {
        
        let point = sender.convert(CGPoint.zero, to: foodCollectionView)
        guard let indexPath = foodCollectionView.indexPathForItem(at: point) else { return }
        
        DispatchQueue.main.async {
            
            // MARK: ActionSheet
            let actionSheet = UIAlertController(title: "맛집 수정, 삭제",
                                                message: "아래 항목을 선택해 주세요.",
                                                preferredStyle: .actionSheet)
            
            let cancelButton = UIAlertAction(title: "취소",
                                       style: .cancel,
                                       handler: nil)
            let modiRestaurant = UIAlertAction(title: "맛집명 변경",
                                               style: .default) {_ in
                
                let modiAlert = UIAlertController(title: "맛집명 변경",
                                                  message: "변경할 맛집의 이름을 입력해주세요.",
                                                  preferredStyle: .alert)
                
                let modiButton = UIAlertAction(title: "변경",
                                               style: .default) {_ in
                    if let txtField = modiAlert.textFields?.first,
                       let text = txtField.text {
                        self.totalRestaurants[indexPath.row].restaurantName = text
                        
                        UserDefaultsManager.shared.saveRestaurants(restaurants: self.totalRestaurants)
                        
                        self.foodCollectionView.reloadData()
                    }
                }
                modiAlert.addTextField { textField in
                    textField.placeholder = "\(self.totalRestaurants[indexPath.row].restaurantName)"
                }
                modiAlert.addAction(modiButton)
                modiAlert.addAction(cancelButton)
                
                self.present(modiAlert, animated: true, completion: nil)
            }
            
            
            let tappedDelete = UIAlertAction(title: "맛집 삭제",
                                             style: .destructive) {_ in
                
                let deleteConfirmAlert = UIAlertController(title: "해당 맛집에 포함된 메뉴들도 삭제 됩니다.",
                                                           message: "정말로 삭제 하시겠습니까?",
                                                           preferredStyle: .alert)
                
                let deleteRestaurant = UIAlertAction(title: "삭제",
                                                     style: .destructive) {_ in
                    
                    self.totalRestaurants.remove(at: indexPath.row)
                    
                    UserDefaultsManager.shared.saveRestaurants(restaurants: self.totalRestaurants)
                    
                    self.foodCollectionView.reloadData()
                    
                }
                
                deleteConfirmAlert.addAction(deleteRestaurant)
                deleteConfirmAlert.addAction(cancelButton)
                self.present(deleteConfirmAlert, animated: true, completion: nil)
            }
            
            actionSheet.addAction(modiRestaurant)
            actionSheet.addAction(tappedDelete)
            actionSheet.addAction(cancelButton)
            
            self.present(actionSheet, animated: true, completion: nil)
            
        }
    }

    // MARK: Methods
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        foodSearchBar.resignFirstResponder()
    }
    
    // MARK: @objc
    @objc func addRestaurant() {
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    // 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = CGSize(width: view.frame.width - 80, height: 150)
        return size
    }
}

// Cell에 대한 delegate
extension RestaurantViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCollectionViewCell
        let restaurant: Restaurant = totalRestaurants[indexPath.row]
        
        
        
        let favoriteMenus = restaurant.likeMenus.filter {
            $0.isFavorite == true
        }
        
        var favoriteString = ""

        if favoriteMenus.isEmpty {
            favoriteString = "즐겨찾는 메뉴를 추가해주세요"

        } else if favoriteMenus.count == 1 {
            favoriteString = "\(favoriteMenus.first?.menu!)"

        } else {
            favoriteString = "\(favoriteMenus.first) (외 ⭐️ \(favoriteMenus.count - 1 )개)"
        }

        
        cell.restaurantNamesLabel.text = restaurant.restaurantName
        cell.favoriteMenuLabel.text = favoriteString
        cell.likeCountLabel.text = "\(restaurant.likeMenus.count)"
        cell.curiousCountLabel.text = "\(restaurant.curiousMenus.count)"
        cell.warningCountLabel.text = "\(restaurant.badMenus.count)"

        
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowOffset = CGSize(width: -2, height: 2)
        cell.layer.shadowRadius = 3
        cell.layer.cornerRadius = 20

        
        return cell
    }
    
    // numberOfItemsInSection: Cell을 몇개 보여줄지
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if totalRestaurants.count == 0 {
            collectionView.setEmptyMessage("맛집이 없어요.\n\n우측 상단 '추가' 버튼을 눌러 맛집을 추가해주세요.")
        } else {
            collectionView.restore()
        }
        return totalRestaurants.count
    }
    
    //
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let menuListVC = MenuListViewController(selectedRestaurant: totalRestaurants[indexPath.row], index: indexPath.row)
        
        
        let backBarButtonItem = UIBarButtonItem(title: "",
                                                style: .plain,
                                                target: self, action: nil)
        
        navigationController?.pushViewController(menuListVC,
                                                 animated: true)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        
        foodSearchBar.resignFirstResponder()
        foodSearchBar.text = ""
        
    }
    
}

#if DEBUG

import SwiftUI
@available(iOS 13.0, *)

// UIViewControllerRepresentable을 채택
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    // update
    // _ uiViewController: UIViewController로 지정
    func updateUIViewController(_ uiViewController: UIViewController , context: Context) {
        
    }
    // makeui
    func makeUIViewController(context: Context) -> UIViewController {
    // Preview를 보고자 하는 Viewcontroller 이름
    // e.g.)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "RestaurantViewController") as! RestaurantViewController
        
    }
}

struct ViewController_Previews: PreviewProvider {
    
    @available(iOS 13.0, *)
    static var previews: some View {
        // UIViewControllerRepresentable에 지정된 이름.
        ViewControllerRepresentable()

// 테스트 해보고자 하는 기기
            .previewDevice("iPhone 12")
    }
}
#endif
