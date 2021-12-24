//
//  ViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/11.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var foodSearchBar: UISearchBar!
    @IBOutlet weak var foodLabel: UILabel!
    var foodList: [String] = ["치킨", "카레", "피자", "대게", "떡볶이", "타코"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodSearchBar.delegate = self
        foodList.map{ foodLabel.text = $0 }
//        foodLabel.text = foods
        
    }

    
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count > 1 {
            print("두글자 입력")
           let filteredFoodArr = foodList.filter { $0 == searchText }
            let filterdFood =  filteredFoodArr.joined(separator: "")
            foodLabel.text = filterdFood
            
            
        }
    }
}
