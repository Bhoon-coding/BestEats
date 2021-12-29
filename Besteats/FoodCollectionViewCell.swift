//
//  FoodCollectionViewCell.swift
//  Besteats
//
//  Created by BH on 2021/12/27.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    
//    @IBOutlet weak var foodButtonLayer: UIButton!
    
    @IBOutlet weak var remindIconsStackView: UIStackView!
    @IBOutlet weak var foodContentsStackView: UIStackView!
    
//    @IBAction func foodButtonAction(_ sender: Any) {
//
//    }
    
}

extension FoodCollectionViewCell: UICollectionViewDelegate {
    
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
        MainViewController()
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
