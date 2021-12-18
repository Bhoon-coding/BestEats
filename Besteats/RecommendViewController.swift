//
//  recommendViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/18.
//

import UIKit

class RecommendViewController: UIViewController {

    @IBOutlet var foodTableImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodTableImageView.image = UIImage(named: "foodsTable")
        
    }
    
}
