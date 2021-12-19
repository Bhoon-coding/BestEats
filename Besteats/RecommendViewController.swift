//
//  recommendViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/18.
//

import UIKit

class RecommendViewController: UIViewController {

    @IBOutlet var foodTableImageView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
    }
    
    func configure() {
        foodTableImageView.image = UIImage(named: "foodsTable")
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 3.0
    }
    
}

extension RecommendViewController: UIScrollViewDelegate {
    // 줌 기능
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.foodTableImageView
    }
    
    // 최대, 최소줌 후 한쪽에 붙는 문제 해결
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.zoomScale <= 1.0 {
            scrollView.zoomScale = 1.0
        }

        if scrollView.zoomScale >= 2.0 {
            scrollView.zoomScale = 2.0
        }
    }
}
