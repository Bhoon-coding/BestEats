//
//  UICollectionView.swift
//  Besteats
//
//  Created by BH on 2022/04/01.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.textColor = .label
            label.numberOfLines = 0;
            label.textAlignment = .center;
            label.font = UIFont(name: "GmarketSansBold", size: 16)
            label.sizeToFit()
            return label
        }()
        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
