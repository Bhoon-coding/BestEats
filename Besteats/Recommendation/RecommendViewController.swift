//
//  recommendViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/18.
//

import UIKit

import SnapKit

final class RecommendViewController: UIViewController {
    
    // MARK: - Enums
    
    

    // MARK: - Properties
    
    let foodTypeName: [String] = ["한식", "피자", "햄버거", "디저트"]
    let foodTypeImages: [UIImage] = [#imageLiteral(resourceName: "tteokbokki"), #imageLiteral(resourceName: "pizza"), #imageLiteral(resourceName: "hamburger"), #imageLiteral(resourceName: "donut")]
    
    private lazy var recommendCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureCollectionView()
    }
    
    // MARK: - Methods
    
    
    // MARK: - @objc
    
    
}

// MARK: - Extensions

extension RecommendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodTypeName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as? RecommendCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell()
        cell.foodTypeLabel.text = foodTypeName[indexPath.item]
        cell.foodTypeImageView.image = foodTypeImages[indexPath.item]
        return cell
    }
}

extension RecommendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 30
        let padding: CGFloat = 16
        let width = (collectionView.bounds.width - itemSpacing * 2 - padding * 2) / 3
        let height = width * 1.2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let foodType: String = foodTypeName[indexPath.item]
        
        
        
        let foodImageVC = FoodImageViewController(foodType: foodType)
        present(foodImageVC, animated: true)
        
        
    }
    
}

extension RecommendViewController {
    private func configureUI() {
        view.backgroundColor = .lightGray
        
        [recommendCollectionView]
            .forEach { view.addSubview($0) }
        
        recommendCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureCollectionView() {
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
        recommendCollectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        
        recommendCollectionView.contentInset = UIEdgeInsets(top: 20,
                                                           left: 16,
                                                           bottom: 0,
                                                           right: 16)
    }
}
