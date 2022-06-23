//
//  APICaller.swift
//  Besteats
//
//  Created by BH on 2022/06/23.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    static let baseUrl: String = "https://api.unsplash.com/search/photos?"
    
    static let headerField: String = "client_id"
}

extension APIManager {
    
    func fetchData(query: String,
                   completion: @escaping (Result<FoodPhotosResults, Error>) -> Void ) {
        guard var urlComponents = URLComponents(string: APIManager.baseUrl) else {
            print("<API Caller> - Error: cannot create URLComponents")
            return
        }
        
        let queryParams = ["query": query,
                           "client_id": Constants.clientId]
        let queryArray = queryParams.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        urlComponents.queryItems = queryArray
        
        guard let requestURL = urlComponents.url else { return }
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: requestURL) { data, _, error in
            guard error == nil else {
                print("<API Manager, fetchData> - \(error!)")
                return
            }
            
            guard let safeData = data else { return }
            let decoder = JSONDecoder()
            
                do {
                    let decodedData = try decoder.decode(FoodPhotosResults.self, from: safeData)
                    
                    completion(.success(decodedData))
                    
                } catch {
                    print("<API Manager> - 데이터가 없습니다.")
                    completion(.failure(error))
                }
            
        }
        dataTask.resume()
    }
}
