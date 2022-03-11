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
//    @IBOutlet weak var foodImageView: UIImageView!
    
    
//    var restaurantNames: [String] = ["BHC", "카레", "엘루이피자", "대게", "중평떡볶이", "낙원타코"]
//    var oneLineTips: [String] = ["뿌링클", "김치랑 먹자", "파마산치즈 듬뿍", "게껍딱 👍", "떡순오가 최고", "대창파히타 > 낙원파히타"]
//    var warningTips: [String?] = ["배달이 1시간 걸림", nil, "화장실 밖", "손조심", nil, "물셀프"]
    
    var restaurantNames: [String] = ["무난무난"]
    var oneLineTips: [String] = ["괜찮"]
    var warningTips: [String?] = [":- )"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodSearchBar.delegate = self
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
//        foodList.map{ foodLabel.text = $0 }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let foodDatas = UserDefaults.standard.value(forKey: "foodDatas") as? Data {
            let getFoodDatas = try? PropertyListDecoder().decode([FoodModiModel].self, from: foodDatas)
            dump(getFoodDatas)
        }
    }
    @IBAction func tapMore(_ sender: Any) {
        guard let BTSheetVC = storyboard?.instantiateViewController(withIdentifier: "BottomSheetViewController") as? BottomSheetViewController else { return }
        
//        moreVC.modalPresentationStyle = .overCurrentContext
        BTSheetVC.modalPresentationStyle = .overFullScreen
        present(BTSheetVC, animated: false, completion: nil)
    }
}

class FoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var restaurantNamesLabel: UILabel!
    @IBOutlet weak var oneLineTipsLabel: UILabel!
    @IBOutlet weak var warningTipsLabel: UILabel!
    
}
extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count > 1 {
           let filteredFoodArr = restaurantNames.filter { $0 == searchText }
            let filterdFood =  filteredFoodArr.joined(separator: "")
            
        }
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
        
        cell.restaurantNamesLabel.text = restaurantNames[indexPath.row]
        cell.oneLineTipsLabel.text = oneLineTips[indexPath.row]
        cell.warningTipsLabel.text = warningTips[indexPath.row]
        
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        

        return cell
    }
    
    // numberOfItemsInSection: Cell을 몇개 보여줄지
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
    // 해당
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let foodDetailVC = FoodDetailViewController()
        navigationController?.pushViewController(foodDetailVC, animated: true)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        print("\(indexPath.item + 1) 번째 셀이 눌림")
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
