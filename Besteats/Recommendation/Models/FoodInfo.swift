//
//  RecommendFoodType.swift
//  Besteats
//
//  Created by BH on 2022/10/11.
//

import Foundation
import UIKit.UIImage

enum FoodType: String {
    case korea
    case western
    case china
    case japan
    case dessert
}

struct FoodInfo {
    
    let type: FoodType
    let image: UIImage
    let label: String
}
