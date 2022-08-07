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

final class RecommendViewController: UIViewController {
   
    // MARK: - UIProperties
    
}
