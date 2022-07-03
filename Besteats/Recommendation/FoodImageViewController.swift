//
//  FoodImageViewController.swift
//  Besteats
//
//  Created by BH on 2022/06/24.
//

import UIKit

import SnapKit

final class FoodImageViewController: UIViewController {
    
    // MARK: - Enums
    
    private enum FoodImageVCString {
        
        
    }
    
    // MARK: - Properties
    
    var imageURLs: [URL] = []
    let foodType: String
    
    init(foodType: String) {
        self.foodType = foodType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIProperties
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Image.close),
                        for: .normal)
        button.addTarget(self,
                         action: #selector(dismissVC),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
//        scrollView.backgroundColor = .cyan
        return scrollView
    }()
    
    private lazy var foodImageView: [UIImageView] = {
        let imageView = [UIImageView]()
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .brown
        return imageView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = imageURLs.count
        pageControl.backgroundColor = #colorLiteral(red: 0.2279180713, green: 0.3073120006, blue: 1, alpha: 1)
        return pageControl
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchImage()
        addContentScrollView()
        
    }
    
    // MARK: - Methods
    
    func fetchImage() {
        APIManager.shared.fetchData(query: foodType) { res in
            switch res {
            case .success(let data):
                let foodInfoResults = data.results
                let foodImageURLs = foodInfoResults.map { foodInfo in
                    URL(string: foodInfo.urls.full)
                }
                foodImageURLs.forEach {
                    self.imageURLs.append($0!)
                }
                DispatchQueue.main.async {
                    self.pageControl.numberOfPages = self.imageURLs.count
                }
                
            case .failure(let error):
                print("<APIManager fetchData> - error: \(error.localizedDescription)")
            }
        }
    }
    
    func addContentScrollView() {
        for i in 0..<imageURLs.count {
            let imageView = UIImageView()
            let xPos = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            imageView.load(url: imageURLs[i])
            scrollView.addSubview(imageView)
            scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
    }
    
    
    // MARK: - @objc
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
}

// MARK: - Extensions

extension FoodImageViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
//        니 앞가림이나 신경써 지금 잡생각하지말고
        
        [
            closeButton,
            scrollView,
//            foodImageView,
            pageControl
        ]
            .forEach { view.addSubview($0) }
        
        [
            foodImageView,
        ]
            .forEach { scrollView.addSubview($0) }
        
        closeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(16)
        }
        
        scrollView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(80)
        }
        
        foodImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(80)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(160)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
//            $0.top.equalTo(foodImageView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
            $0.height.equalTo(60)
        }
        
    }
    
}

// 전처리
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
        return FoodImageViewController(foodType: "aaa")
    }
}

struct ViewController_Previews: PreviewProvider {
    
    @available(iOS 13.0, *)
    static var previews: some View {
        // UIViewControllerRepresentable에 지정된 이름.
        ViewControllerRepresentable()
        
        // 테스트 해보고자 하는 기기
            .previewDevice("iPhone 11")
    }
}
#endif
