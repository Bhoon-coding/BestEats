//
//  Bundle + extension.swift
//  Besteats
//
//  Created by BH on 2022/08/08.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let file = self.path(forResource: "FoodPhotoInfo", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else {
            return ""
        }
        guard let key = resource["API_KEY"] as? String else {
            fatalError("FoodPhotoInfo.plist에 API_KEY를 설정 해주세요.")
        }
        return key
    }
}
