//
//  recommendViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/18.
//

import UIKit

import RxSwift
import SnapKit

final class RecommendDetailViewController: UIViewController {
   
    // MARK: - UIProperties
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Style.padding
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    // MARK: - Properties
    
    private var foodInfo: [Search.Photos.FoodPhotosResponse.FoodPhotosInfo] = []
    var foodType: String
    let disposeBag = DisposeBag()
    
    
    // MARK: - LifeCycles
    
    init(foodType: String) {
        self.foodType = foodType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        fetchFood()
    }
    
    // MARK: - Methods
    
    private func fetchFood() {
        SearchService()
            .request(parameters: Search.Photos.FoodPhotoParameter(foodType: foodType))
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] response in
                self?.foodInfo = response.results
                self?.collectionView.reloadData()
            } onFailure: { error in
                // TODO: [] Crashlytics
                print("=================== \(#function) error: \(error) ===================")
            }.disposed(by: disposeBag)
    }
}

// MARK: - Configure UI

extension RecommendDetailViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        [collectionView].forEach { view.addSubview($0) }
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.register(
            RecommendFoodCell.self,
            forCellWithReuseIdentifier: String(describing: RecommendFoodCell.self)
        )
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

// MARK: - Configure Constraints

extension RecommendDetailViewController {
    
    private func configureConstraints() {
        configureConstraintsOfCollectionView()
    }
    
    private func configureConstraintsOfCollectionView() {
        collectionView.snp.makeConstraints {
            $0.top.trailing.bottom.leading.equalToSuperview()
        }
    }
    
}

// MARK: - CollectionView DataSource

extension RecommendDetailViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return foodInfo.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: RecommendFoodCell.self),
            for: indexPath
        ) as? RecommendFoodCell else {
            return UICollectionViewCell()
        }
        let foodItem = foodInfo[indexPath.item]
        cell.setupImage(URL(string: foodItem.urls.small)!)
        return cell
    }
    
}

// MARK: - CollectionView DelegateFlowLayout

extension RecommendDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.9,
                      height: collectionView.frame.height * 0.3)
    }
    
}

// MARK: - NameSpaces

extension RecommendDetailViewController {
    
    private enum Style {
        static let padding: CGFloat = 16
    }
    
}

//
//// 전처리
//#if DEBUG
//
//import SwiftUI
//@available(iOS 13.0, *)
//
//// UIViewControllerRepresentable을 채택
//struct RecommendDetailViewControllerRepresentable: UIViewControllerRepresentable {
//    // update
//    // _ uiViewController: UIViewController로 지정
//    func updateUIViewController(_ uiViewController: UIViewController , context: Context) {
//
//    }
//    // makeui
//    func makeUIViewController(context: Context) -> UIViewController {
//        // Preview를 보고자 하는 Viewcontroller 이름
//        // e.g.)
//        return RecommendDetailViewController()
//    }
//}
//
//struct RecommendDetailViewController_Previews: PreviewProvider {
//
//    @available(iOS 13.0, *)
//    static var previews: some View {
//        // UIViewControllerRepresentable에 지정된 이름.
//        RecommendDetailViewControllerRepresentable()
//
//        // 테스트 해보고자 하는 기기
//            .previewDevice("iPhone 11")
//    }
//}
//#endif
