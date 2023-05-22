//
//  APICaller.swift
//  Besteats
//
//  Created by BH on 2022/06/23.
//

import Foundation

import Alamofire

class APIManager {
    
    static let shared = APIManager()
//    static let baseUrl: String = "https://api.odcloud.kr/api" // 공공데이터포털
    static let baseUrl: String = "https://api.unsplash.com/search/photos" // unsplash
    static let headerField: String = "client_id"
    
}

extension APIManager {
    
    func fetchData(query: String,
                   completion: @escaping (Result<FoodPhotosResults, Error>) -> Void) {
        
        let params: [String: String] = [
            "query": query,
            "client_id": Constants.clientId
        ]
        AF.request(APIManager.baseUrl,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default
        )
        .validate(statusCode: 200...299)
        .responseDecodable(of: FoodPhotosResults.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
