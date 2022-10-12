//
//  CustomCollectionViewLayout.swift
//  Pods
//
//  Created by BH on 2022/08/07.
//

import UIKit

//class CustomCollectionViewLayout: UICollectionViewLayout {
//
//    weak var delegate: CustomCollectionViewLayoutDelegate?
//
//    private let numberOfColums = 2
//    private let cellPadding: CGFloat = 3.0
//    var yOffset: [CGFloat] = Array(repeating: 0, count: 2)
//    private var cache: [UICollectionViewLayoutAttributes] = []
//
//    private var contentHeight: CGFloat = 0
//    private var contentWidth: CGFloat {
//        guard let collectionView = collectionView else {
//            return 0
//        }
//        let insets = collectionView.contentInset
//        return collectionView.bounds.width - (insets.left + insets.right)
//    }
//    override var collectionViewContentSize: CGSize {
//        return CGSize(width: contentWidth, height: contentHeight)
//    }
//
//    override func prepare() {
//
//        guard let collectionView = collectionView else { return }
//        let collectionViewItems = collectionView.numberOfItems(inSection: 0)
//        if collectionViewItems == cache.count { return }
//
//        let columnWidth = contentWidth / CGFloat(numberOfColums)
//        var xOffset: [CGFloat] = []
//        var column = yOffset[0] <= yOffset[1] ? 0 : 1
//        for column in 0..<numberOfColums {
//            xOffset.append(CGFloat(column) * columnWidth)
//        }
//
//        for item in cache.count..<collectionView.numberOfItems(inSection: 0) {
//            let indexPath = IndexPath(item: item, section: 0)
//
//            let photoHeight = delegate?.collectionView(
//                collectionView,
//                heightForPhotoAtIndexPath: indexPath
//            ) ?? 180
//
//            let photoWidth = delegate?.collectionView(
//                collectionView,
//                widthForPhotoAtIndexPath: indexPath
//            ) ?? columnWidth
//            let height = cellPadding * 2 + columnWidth * photoHeight / photoWidth
//
//            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
//
//            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
//
//            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//            attributes.frame = insetFrame
//            cache.append(attributes)
//
//            contentHeight = max(contentHeight, frame.maxY)
//            yOffset[column] = yOffset[column] + height
//
//            column = yOffset[0] <= yOffset[1] ? 0 : 1
//        }
//    }
//
//    override func layoutAttributesForElements(
//        in rect: CGRect
//    ) -> [UICollectionViewLayoutAttributes]? {
//        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
//
//        for attributes in cache {
//            if attributes.frame.intersects(rect) {
//                visibleLayoutAttributes.append(attributes)
//            }
//        }
//        return visibleLayoutAttributes
//    }
//
//    override func layoutAttributesForItem(
//        at indexPath: IndexPath
//    ) -> UICollectionViewLayoutAttributes? {
//        return cache[indexPath.item]
//    }
//
//}
