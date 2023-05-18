//
//  NetworkManager.swift
//  
//
//  Created by BH on 2023/05/18.
//

import Foundation

import Alamofire
import RxCocoa
import RxSwift

class NetworkManager {
    static let instance = NetworkManager()
    
    let session: Session
    
    private init() {
        // TODO: []
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 4
//        configuration.httpMaximumConnectionsPerHost = 4
//        session = session(configuration: configuration, Interceptor: )
    }
    
    static func request<R: Codable>(host: String = APICommon.host,
                                    parameters: Parameters? = nil,
                                    path: String,
                                    method: HTTPMethod = .get,
                                    header: HTTPHeaders? = nil,
                                    encoding: ParameterEncoding = URLEncoding(destination: .methodDependent,
                                                                              arrayEncoding: .brackets,
                                                                              boolEncoding: .literal)
    ) -> Single<R> {
        Single<R>.create { observer in
            guard let url = URL(string: host + path) else {
                observer(.failure(<#T##Error#>))
            }
            
        }
    }
}


private final class NetworkIntercepter: RequestInterceptor {
    /// 최대 retry count 지정. 3번
    static let maximumRetryCount: Int = 3
    
    /// 로그 등록
    
}
