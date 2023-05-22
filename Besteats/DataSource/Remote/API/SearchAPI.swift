//
//  SearchAPI.swift
//  Besteats
//
//  Created by BH on 2023/05/22.
//

import Foundation

import Alamofire
import RxSwift

extension Search {
    struct Photos: APIDefinition {
        // TODO: [] Codable or query, clientID 파라미터로 받기
        struct FoodPhotosResponse: Codable {
            let total: Int
            let totalPages: Int
            let results: [FoodPhotosInfo]
            
            enum CodingKeys: String, CodingKey {
                case total, results
                case totalPages = "total_pages"
            }
            
            struct FoodPhotosInfo: Codable {
                let urls: ImageSize
                
                struct ImageSize: Codable {
                    let raw, full, small: String
                }
            }
        }
        
        
        var path: String = "/search/photos"
        
        var headers: HTTPHeaders?
        
        var method: HTTPMethod = .get
        
        
    }
}
