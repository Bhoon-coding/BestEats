//
//  Extension.swift
//  Besteats
//
//  Created by BH on 2022/02/28.
//

import Foundation
import UIKit

import SnapKit

// MARK: UICollectionView
extension UICollectionView {
    
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
        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}

// MARK: UITextField
extension UITextField {
    
    func placeholderConvention(textField: UITextField) {
        textField.font = UIFont(name: "BM JUA_OTF", size: 18)
        textField.backgroundColor = .systemBackground
//        textField.pla
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

// MARK: CALayer
extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

extension UIView {
    func circleView(_ view: UIView) {
        view.layer.cornerRadius = view.layer.bounds.width/2
        view.clipsToBounds = true
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 7
    }
}

extension UIButton {
    func mediumButton (button: UIButton) {
        button.titleLabel?.font = UIFont(name: "BM JUA_OTF", size: 18)
        button.layer.cornerRadius = 8
        
    }
}

extension UILabel {
    func bigLabel(label: UILabel) {
        label.font = UIFont(name: "BM JUA_OTF", size: 24)
        label.textColor = .label
    }
    
    func mediumLabel(label: UILabel) {
        label.font = UIFont(name: "BM JUA_OTF", size: 18)
        label.textColor = .label
    }
    
    func smallLabel(label: UILabel) {
        label.font = UIFont(name: "BM JUA_OTF", size: 16)
        label.textColor = .label
    }
}
