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
        
        struct FoodPhotoParameter {
            let clientId: String = Constants.clientId
            let foodType: String
            
        }
        // TODO: [] API 응답 값 Cell에 보여주기 (total page 쿼리 추가 필요)
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
        
        var parameters: BestEatsParameters?
        
        var method: HTTPMethod = .get
        
        init(parameters: FoodPhotoParameter) {
            let params = BestEatsParameters()
            params.append(.init(key: .clientId, value: parameters.clientId))
            params.append(.init(key: .query, value: parameters.foodType))
            
            self.parameters = params
            
        }
    }
}

protocol SearchServiceable {
    func request(parameters: Search.Photos.FoodPhotoParameter) ->  Single<Search.Photos.FoodPhotosResponse>
}

struct SearchService: SearchServiceable {
    func request(parameters: Search.Photos.FoodPhotoParameter) -> Single<Search.Photos.FoodPhotosResponse> {
        Search.Photos(parameters: parameters)
            .rx
            .request()
    }
}

extension Reactive where Base == Search.Photos {
    func request() -> Single<Search.Photos.FoodPhotosResponse> {
        NetworkManager.request(parameters: base.parameters,
                               path: base.path,
                               method: base.method,
                               header: base.headers,
                               encoding: URLEncoding.default)
        
    }
}
