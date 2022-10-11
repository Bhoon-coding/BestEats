//
//  RecommendViewController.swift
//  Besteats
//
//  Created by BH on 2022/10/11.
//

import UIKit

import SnapKit

final class RecommendViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        view.backgroundColor = .brown
    }
    
    
}

// MARK: - Configure UI

extension RecommendViewController {

    private func configureUI() {
        
    }
    
}

// MARK: - Configure Constraints

extension RecommendViewController {
    
    private func configureConstraints() {
        
    }
    
}

// 전처리
#if DEBUG

import SwiftUI
@available(iOS 13.0, *)

// UIViewControllerRepresentable을 채택
struct RecommendViewControllerRepresentable: UIViewControllerRepresentable {
    // update
    // _ uiViewController: UIViewController로 지정
    func updateUIViewController(_ uiViewController: UIViewController , context: Context) {

    }
    // makeui
    func makeUIViewController(context: Context) -> UIViewController {
        // Preview를 보고자 하는 Viewcontroller 이름
        // e.g.)
        return RecommendViewController()
    }
}

struct ViewController_Previews: PreviewProvider {

    @available(iOS 13.0, *)
    static var previews: some View {
        // UIViewControllerRepresentable에 지정된 이름.
        RecommendViewControllerRepresentable()

        // 테스트 해보고자 하는 기기
            .previewDevice("iPhone 11")
    }
}
#endif
