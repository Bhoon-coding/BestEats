//
//  recommendViewController.swift
//  Besteats
//
//  Created by BH on 2021/12/18.
//

import UIKit

import SnapKit

protocol CustomCollectionViewLayoutDelegate: AnyObject {
    
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath
    ) -> CGFloat
    
    func collectionView(
        _ collectionView: UICollectionView,
        widthForPhotoAtIndexPath indexPath: IndexPath
    ) -> CGFloat
    
}

final class RecommendDetailViewController: UIViewController {
   
    // MARK: - UIProperties
    
    private lazy var collectionView: UICollectionView = {
        let layout = CustomCollectionViewLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            RecommendCollectionViewCell.self,
            forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier
        )
        return collectionView
    }()
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupConstraints()
//        fetchPhotos()
    }
}

// MARK: - Layout extension

extension RecommendDetailViewController {
    
    private func setupCollectionView() {
        if let layout = collectionView.collectionViewLayout as?  CustomCollectionViewLayout {
            layout.delegate = self
        }
        collectionView.dataSource = self
//        collectionView.delegate = self
        
        [collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        setupConstraintsOfCollectionView()
    }
    
    private func setupConstraintsOfCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            collectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
    
}

// MARK: - CollectionView DataSource extension

extension RecommendDetailViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecommendCollectionViewCell.identifier,
            for: indexPath
        ) as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
      
        cell.setupCell()
        return cell
    }
    
}

// MARK: - CustomCollectionViewLayoutDelegate extension
// TODO: [] 사진 데이터의 width, heigth 값 넣어놓기
extension RecommendDetailViewController: CustomCollectionViewLayoutDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath
    ) -> CGFloat {
//        return CGFloat(photos[indexPath.item].height)
        return 200
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        widthForPhotoAtIndexPath indexPath: IndexPath
    ) -> CGFloat {
//        return CGFloat(photos[indexPath.item].width)
        return 100
    }

}
