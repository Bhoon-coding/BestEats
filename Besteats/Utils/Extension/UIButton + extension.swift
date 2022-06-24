//
//  UIButton.swift
//  Besteats
//
//  Created by BH on 2022/04/01.
//

import Foundation
import UIKit

extension UIButton {
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let margin: CGFloat = 10
        let hitArea = self.bounds.insetBy(dx: -margin, dy: -margin)
        return hitArea.contains(point)
    }
    
    func mediumButton (button: UIButton) {
        button.titleLabel?.font = UIFont(name: Fonts.bold, size: 14)
        button.layer.cornerRadius = 8
        
    }
}
