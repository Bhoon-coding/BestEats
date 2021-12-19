//
//  recommendViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/18.
//

import UIKit

class RecommendViewController: UIViewController {

    @IBOutlet var foodTableImageView: UIImageView!
    
    var initialImageSize: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(doPinch))
        self.view.addGestureRecognizer(pinch)

        foodTableImageView.image = UIImage(named: "foodsTable")
        
    }
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        foodTableImageView.transform = foodTableImageView.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        pinch.scale = 1
    }
    
}
