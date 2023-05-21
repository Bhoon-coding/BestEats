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
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 4
        configuration.httpMaximumConnectionsPerHost = 4
        session = Session(configuration: configuration, interceptor: NetworkIntercepter())
    }
    
    static func request<R: Codable>(host: String = APICommon.host,
//                                    parameters: Parameters? = nil,
                                    path: String,
                                    method: HTTPMethod = .get,
                                    header: HTTPHeaders? = nil,
                                    encoding: ParameterEncoding = URLEncoding(destination: .methodDependent,
                                                                              arrayEncoding: .brackets,
                                                                              boolEncoding: .literal)
    ) -> Single<R> {
        Single<R>.create { observer in
            guard let url = URL(string: host + path) else {
                observer(.failure(BestEatsError.NetworkError.invalidURL))
                return Disposables.create()
            }
            
            let request = NetworkManager.instance.session
                .request(url,
                         method: method,
                         parameters: nil,
                         encoding: encoding,
                         headers: header)
                .responseDecodable(of: R.self) { res in
                    
                    var responseBodyString = ""
                    
                    /// response 확인용
                    if let responseBody = res.data,
                       let stringData = String(data: responseBody, encoding: .utf8)
                    {
                        responseBodyString = stringData
                    }
                    
                    switch res.result {
                        /// 실패시
                    case let .failure(afError):
                        print(afError)
                        print("||")
                        print("|| host : \(res.request?.url?.host ?? "")")
                        print("|| request path : \(res.request?.url?.path ?? "")")
                        print("|| request url : \(res.request?.url?.absoluteString ?? "")")
                        print("|| request headers : \(res.request?.headers ?? [:])")
                        print("|| response body : \(responseBodyString)")
                        print("|| http Code : \(res.response?.statusCode ?? -1)")
                        print("||")
                        print("==============================")
                        
                        if let response = res.response {
                            observer(.failure(BestEatsError.NetworkError.apiError(definition: CommonAPIError(httpStatusCode: response.statusCode, errorMsg: afError.failureReason))))
                            return
                        }
                        
                        // Check network unavailable
                        guard let httpResponse = res.response,
                              let httpError = NetworkManager.createHttpError(httpResponse, error: afError) else {
                            // Check pasing fail
                            do {
                                if let rawData = res.data {
                                    _ = try JSONDecoder().decode(R.self, from: rawData)
                                } else {
                                    observer(.failure(BestEatsError.NetworkError.parsingFail))
                                    return
                                }
                            } catch {
                                print(afError)
                                observer(.failure(BestEatsError.NetworkError.parsingFail))
                                return
                            }
                            observer(.failure(afError))
                            return
                        }
                        
                        observer(.failure(httpError))
                        
                    case let .success(response):
                        print("========= Response 🎁 =========")
                        print("||")
                        print("|| host : \(res.request?.url?.host ?? "")")
                        print("|| request path : \(res.request?.url?.path ?? "")")
                        print("|| request url : \(res.request?.url?.absoluteString ?? "")")
                        print("|| response body : \(responseBodyString)")
                        print("|| http Code : \(res.response?.statusCode ?? -1)")
                        print("||")
                        print("==============================")
                        observer(.success(response))
                    }
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    static func createHttpError(_ response: HTTPURLResponse, error: AFError?) -> BestEatsError.NetworkError? {
        if response.statusCode >= 200, response.statusCode < 300 {
            return nil
        }
        
        if let nsError = error as NSError? {
            // when no status code available, check timeout of networkAvailability
            if nsError.code == CFNetworkErrors.cfurlErrorTimedOut.rawValue {
                return BestEatsError.NetworkError.networkTimeout
            } else if nsError.code == CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue
                        || nsError.code == CFNetworkErrors.cfurlErrorCannotFindHost.rawValue
                        || nsError.code == CFNetworkErrors.cfurlErrorCannotConnectToHost.rawValue
                        || nsError.code == CFNetworkErrors.cfurlErrorNetworkConnectionLost.rawValue
                        || nsError.code == CFNetworkErrors.cfurlErrorDNSLookupFailed.rawValue
            {
                return BestEatsError.NetworkError.networkUnavailable
            }
            return nil
        }
        return nil
    }
}


private final class NetworkIntercepter: RequestInterceptor {
    /// 최대 retry count 지정. 3번
    static let maximumRetryCount: Int = 3
    
    /// 로그 등록
    
}
