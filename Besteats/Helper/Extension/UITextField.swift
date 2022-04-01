//
//  UITextField.swift
//  Besteats
//
//  Created by BH on 2022/04/01.
//

import Foundation
import UIKit

extension UITextField {
    
    func placeholderConvention(textField: UITextField) {
        textField.font = UIFont(name: "BM JUA_OTF", size: 18)
        textField.backgroundColor = .systemBackground
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

