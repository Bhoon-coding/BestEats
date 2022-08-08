//
//  NetworkRequester.swift
//  Besteats
//
//  Created by BH on 2022/08/08.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case requestFail(Error)
    case invalidResponse
    case failedResponse(statusCode: Int)
    case emptyData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .requestFail:
            return "HTTP 요청에 실패했습니다."
        case .invalidResponse:
            return "유효하지 않은 응답입니다."
        case .failedResponse(let statusCode):
            return "(\(statusCode)) 실패한 상태코드"
        case .emptyData:
            return "데이터가 없습니다."
        }
    }
}

protocol NetworkRequesterType {
    
    func request(to endPoint: EndPointType, completion: @escaping (Result<Data, NetworkError>) -> Void)
    
    func request(to urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionDataTask?
    
}

struct NetworkRequester: NetworkRequesterType {
    
    private let session: URLSession = .shared
    
    func request(
        to endPoint: EndPointType,
        completion: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        guard let urlRequest = endPoint.asURLRequest() else {
            completion(.failure(.invalidURL))
            return
        }
        dataTask(request: urlRequest, completion: completion).resume()
    }
    
    func request(to urlString: String,
                 completion: @escaping (Result<Data, NetworkError>) -> Void
    ) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return nil
        }
        let urlRequest = URLRequest(url: url)
        let task = dataTask(request: urlRequest, completion: completion)
        task.resume()
        return task
    }
    
    private func dataTask(
        request: URLRequest,
        completion: @escaping (Result<Data, NetworkError>) -> Void
    ) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFail(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.failedResponse(statusCode: httpResponse.statusCode)))
                return
            }
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            completion(.success(data))
        }
        return task
    }
    
}
