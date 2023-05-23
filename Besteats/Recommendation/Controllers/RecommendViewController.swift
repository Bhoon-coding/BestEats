//
//  RecommendViewController.swift
//  Besteats
//
//  Created by BH on 2022/10/11.
//

import UIKit

import SnapKit

final class RecommendViewController: UIViewController {
    
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
    
    private let sectionInsets = Style.sectionInsets
    private let foodTypeData: [RecommendFoodType] = [
        RecommendFoodType(foodTypeImage: Style.koreanFoodImage, foodTypeLabel: Text.koreaFood),
        RecommendFoodType(foodTypeImage: Style.westernFoodImage, foodTypeLabel: Text.westernFood),
        RecommendFoodType(foodTypeImage: Style.chineeseFoodImage, foodTypeLabel: Text.chinaFood),
        RecommendFoodType(foodTypeImage: Style.japaneseFoodImage, foodTypeLabel: Text.japanFood),
        RecommendFoodType(foodTypeImage: Style.dessertFoodImage, foodTypeLabel: Text.dessert)
    ]
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
}

// MARK: - Configure UI

extension RecommendViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        [collectionView].forEach { view.addSubview($0) }
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.register(
            RecommendFoodTypeCell.self,
            forCellWithReuseIdentifier: String(describing: RecommendFoodTypeCell.self)
        )
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

// MARK: - Configure Constraints

extension RecommendViewController {
    
    private func configureConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.trailing.bottom.leading.equalToSuperview()
        }
    }
    
}

// MARK: - CollectionView DataSource

extension RecommendViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return foodTypeData.count
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: RecommendFoodTypeCell.self),
            for: indexPath
        ) as? RecommendFoodTypeCell else { return UICollectionViewCell() }
        let foodTypeData = foodTypeData[indexPath.item]
        cell.setupCell(foodTypeData: foodTypeData)
        return cell
    }
    
}

// MARK: - CollectionView DelegateFlowLayout

extension RecommendViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: collectionView.frame.width * 0.9,
            height: collectionView.frame.height * 0.2
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let foodType = foodTypeData[indexPath.item].foodTypeLabel
        let recommendDetailVC = RecommendDetailViewController(foodType: foodType)
        self.navigationController?.pushViewController(recommendDetailVC,
                                                      animated: true)
    }
    
}


// MARK: - NameSpaces

extension RecommendViewController {
    
    private enum Text {
        static let koreaFood: String = "한식"
        static let westernFood: String = "양식"
        static let chinaFood: String = "중식"
        static let japanFood: String = "일식"
        static let dessert: String = "디저트"
    }
    
    private enum Style {
        static let sectionInsets: UIEdgeInsets = .init(top: 32, left: 16, bottom: 100, right: 16)
        static let padding: CGFloat = 16
        static let koreanFoodImage: UIImage = UIImage(named: "KoreanFood")!
        static let westernFoodImage: UIImage = UIImage(named: "WesternFood")!
        static let chineeseFoodImage: UIImage = UIImage(named: "ChineeseFood")!
        static let japaneseFoodImage: UIImage = UIImage(named: "JapaneseFood")!
        static let dessertFoodImage: UIImage = UIImage(named: "DessertFood")!
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
