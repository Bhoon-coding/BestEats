//
//  Extension.swift
//  Besteats
//
//  Created by BH on 2022/02/28.
//

import Foundation
import UIKit

extension UITextField {
    func paddingLeft() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
