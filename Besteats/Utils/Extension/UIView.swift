//
//  UIView.swift
//  Besteats
//
//  Created by BH on 2022/04/01.
//

import Foundation
import UIKit

extension UIView {
    func circleView(_ view: UIView) {
        view.layer.cornerRadius = view.layer.bounds.width/2
        view.clipsToBounds = true
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 7
    }
}
