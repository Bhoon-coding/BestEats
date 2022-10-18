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
    static let baseUrl: String = "https://api.unsplash.com/search/photos?"
    static let headerField: String = "client_id"
    
}

extension APIManager {
    
    func fetchData(
        query: String,
        completion: @escaping (Result<FoodPhotosResults, Error>) -> Void
    ) {
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
              
    
    
//    func fetchData(query: String,
//                   completion: @escaping (Result<FoodPhotosResults, Error>) -> Void ) {
//        guard var urlComponents = URLComponents(string: APIManager.baseUrl) else {
//            print("<API Caller> - Error: cannot create URLComponents")
//            return
//        }
//
//        let queryParams = ["query": query,
//                           "client_id": Constants.clientId]
//        let queryArray = queryParams.map {
//            URLQueryItem(name: $0.key, value: $0.value)
//        }
//        urlComponents.queryItems = queryArray
//
//        guard let requestURL = urlComponents.url else { return }
//        let session = URLSession(configuration: .default)
//
//        let dataTask = session.dataTask(with: requestURL) { data, res, error in
//            guard error == nil else {
//                print("<API Manager, fetchData> - \(error!)")
//                return
//            }
//
//            guard let safeData = data else { return }
//            let decoder = JSONDecoder()
//
//                do {
//                    let decodedData = try decoder.decode(FoodPhotosResults.self, from: safeData)
//
//                    completion(.success(decodedData))
//
//                } catch {
//                    print("<API Manager> - 데이터가 없습니다.")
//                    completion(.failure(error))
//                }
//
//        }
//        dataTask.resume()
//    }
}
