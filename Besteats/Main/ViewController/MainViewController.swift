//
//  ViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/11.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var foodSearchBar: UISearchBar!
    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    var totalRestaurants: [Restaurants] = []
    
    // MARK: LifeCycle
    
    override func loadView() {
        super.loadView()
        
         totalRestaurants = UserDefaultsManager.shared.getRestaurants()
        
        DispatchQueue.main.async {
            self.foodCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodSearchBar.delegate = self
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addRestaurant))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        totalRestaurants = UserDefaultsManager.shared.getRestaurants()
        
        DispatchQueue.main.async {
            self.foodCollectionView.reloadData()
        }
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        foodSearchBar.resignFirstResponder()
    }
    
    // MARK: 보류
    @IBAction func tapMore(_ sender: UIButton) {
        
        let point = sender.convert(CGPoint.zero, to: foodCollectionView)
        guard let indexPath = foodCollectionView.indexPathForItem(at: point) else { return }
        
        // MARK: ActionSheet
        let actionSheet = UIAlertController(title: "맛집 수정, 삭제",
                                            message: "아래 항목을 선택해 주세요.",
                                            preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let modiRestaurant = UIAlertAction(title: "맛집명 변경", style: .default) {_ in
            let modiAlert = UIAlertController(title: "맛집명 변경",
                                              message: "변경할 맛집의 이름을 입력해주세요.",
                                              preferredStyle: .alert)
            let modi = UIAlertAction(title: "변경", style: .default) {_ in
                if let txtField = modiAlert.textFields?.first,
                   let text = txtField.text {
                    self.totalRestaurants[indexPath.row].restaurantName = text
                    
                    UserDefaultsManager.shared.saveRestaurants(restaurants: self.totalRestaurants)
                    
                    DispatchQueue.main.async {
                        self.foodCollectionView.reloadData()
                    }
                }
            }
            modiAlert.addTextField { textField in
                textField.placeholder = "\(self.totalRestaurants[indexPath.row].restaurantName)"
            }
            modiAlert.addAction(modi)
            modiAlert.addAction(cancel)
            
            DispatchQueue.main.async {
                self.present(modiAlert, animated: true, completion: nil)
            }
            
        }
        
        let tappedDelete = UIAlertAction(title: "맛집 삭제", style: .destructive) {_ in
            
            // MARK: Alert
            let deleteConfirmAlert = UIAlertController(title: "해당 맛집에 포함된 메뉴들도 삭제 됩니다.",
                                                       message: "정말로 삭제 하시겠습니까?",
                                                       preferredStyle: .alert)
            
            let deleteRestaurant = UIAlertAction(title: "삭제", style: .destructive) {_ in
                
                
                self.totalRestaurants.remove(at: indexPath.row)
                
                UserDefaultsManager.shared.saveRestaurants(restaurants: self.totalRestaurants)
                
                DispatchQueue.main.async {
                    self.foodCollectionView.reloadData()
                }
                
            }
            
            DispatchQueue.main.async {
                deleteConfirmAlert.addAction(deleteRestaurant)
                deleteConfirmAlert.addAction(cancel)
                self.present(deleteConfirmAlert, animated: true, completion: nil)
            }
        }
        
        actionSheet.addAction(modiRestaurant)
        actionSheet.addAction(tappedDelete)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
        
        
        // 보톰시트 커스텀 보류
//        guard let BTSheetVC = storyboard?.instantiateViewController(withIdentifier: "BottomSheetViewController") as? BottomSheetViewController else { return }
//
//        BTSheetVC.modalPresentationStyle = .overFullScreen
//        present(BTSheetVC, animated: false, completion: nil)
    }
    
    // MARK: @objc
    @objc func addRestaurant() {
        let restaurantAddVC = RestaurantAddViewController()
        restaurantAddVC.delegate = self
        restaurantAddVC.modalPresentationStyle = .fullScreen
        present(restaurantAddVC, animated: true, completion: nil)
    }
}

class FoodCollectionViewCell: UICollectionViewCell {
    
    // MARK: Cell Outlet
    @IBOutlet weak var restaurantNamesLabel: UILabel!
    @IBOutlet weak var bestMenuLabel: UILabel!
    
    @IBOutlet weak var typeCountStackView: UIStackView!
    @IBOutlet weak var likeCountView: UIView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var curiousContView: UIView!
    @IBOutlet weak var curiousCountLabel: UILabel!
    @IBOutlet weak var warningCountView: UIView!
    @IBOutlet weak var warningCountLabel: UILabel!
    
}

extension MainViewController: UISearchBarDelegate {
    
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
extension MainViewController: UICollectionViewDelegateFlowLayout {
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    // 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    // Cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = CGSize(width: 320, height: 150)
        return size
    }
}

// Cell에 대한 delegate
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCollectionViewCell
        
        let filterLikeMenu = totalRestaurants[indexPath.row].menu.filter { $0.type == "like" }
        let filterCuriousMenu = totalRestaurants[indexPath.row].menu.filter { $0.type == "curious" }
        let filterWarningMenu = totalRestaurants[indexPath.row].menu.filter { $0.type == "warning" }
        
        cell.restaurantNamesLabel.text = totalRestaurants[indexPath.row].restaurantName
        // MARK: need refactor (대표메뉴 한줄팁 필요)
        cell.bestMenuLabel.text = totalRestaurants[indexPath.row].menu.isEmpty
        ? "최애 메뉴를 추가해주세요."
        : totalRestaurants[indexPath.row].menu[0].menu
//        cell.oneLineTipsLabel.text = "대표 메뉴명"
        cell.likeCountView.circleView(cell.likeCountView)
        cell.likeCountLabel.text = "\(filterLikeMenu.count)"
        cell.curiousContView.circleView(cell.curiousContView)
        cell.curiousCountLabel.text = "\(filterCuriousMenu.count)"
        cell.warningCountView.circleView(cell.warningCountView)
        cell.warningCountLabel.text = "\(filterWarningMenu.count)"

        
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 1
        
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let menuListVC = MenuListViewController(selectedRestaurant: totalRestaurants[indexPath.row],
                                                    index: indexPath.row)
        
        
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

extension MainViewController: SendUpdateDelegate {
    func sendUpdate(foodsData: [Restaurants]) {
        totalRestaurants = foodsData
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
        return storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
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
