//
//  UITableView.swift
//  Besteats
//
//  Created by BH on 2022/04/04.
//

import Foundation
import UIKit

import SnapKit

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.textColor = .label
            label.numberOfLines = 0;
            label.textAlignment = .center;
            label.font = UIFont(name: "BM JUA_OTF", size: 18)
            label.sizeToFit()
            return label
        }()
        
        self.backgroundView = messageLabel
        
    }

    func restore() {
        self.backgroundView = nil
    }
}



