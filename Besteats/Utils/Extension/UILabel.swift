//
//  UILabel.swift
//  Besteats
//
//  Created by BH on 2022/04/01.
//

import Foundation
import UIKit

extension UILabel {
    func bigLabel(label: UILabel) {
        label.font = UIFont(name: "GmarketSansBold", size: 20)
        label.textColor = .label
    }
    
    func mediumLabel(label: UILabel) {
        label.font = UIFont(name: "GmarketSansBold", size: 16)
        label.textColor = .label
    }
    
    func smallLabel(label: UILabel) {
        label.font = UIFont(name: "GmarketSansBold", size: 14)
        label.textColor = .label
    }
}
