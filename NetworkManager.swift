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
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 4
        configuration.httpMaximumConnectionsPerHost = 4
        session = Session(configuration: configuration, interceptor: NetworkIntercepter())
    }
    
    static func request<R: Codable>(host: String = APICommon.host,
                                    parameters: BestEatsParameters? = nil,
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
                         parameters: parameters?.toDictionary(),
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
                        print("=================== \(#function) 성공결과: \(response) ===================")
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
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var jsonHttpBodyString = ""
        
        if let httpBodyData = urlRequest.httpBody,
           let stringData = String(data: httpBodyData, encoding: .utf8)
        {
            jsonHttpBodyString = stringData
        }
        print("========= Request 🚀 =========")
        print("||")
        print("|| host : \(urlRequest.url?.host ?? "")")
        print("|| path : \(urlRequest.url?.path ?? "")")
        print("|| method : \(urlRequest.httpMethod ?? "")")
        print("|| header : \(urlRequest.headers)")
        if !jsonHttpBodyString.isEmpty {
            print("|| requestbody : \(jsonHttpBodyString)")
        }
        print("||")
        print("==============================")
        completion(.success(urlRequest))
    }
    
    /// 네트워크 연결 유실 시 Retry 설정
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // 최대 retry count 도달 시 session cancel, retry 종료
        guard request.retryCount < NetworkIntercepter.maximumRetryCount else {
            print("NetworkRetryHandler retry finished..")
            session.cancelAllRequests()
            completion(.doNotRetry)
            return
        }
        
        // Device Network 연결 유실, timeout 발생 시 1.5초 간격 Retry 시도
        if let nsError = ((error.asAFError)?.underlyingError as? NSError),
           nsError.code == CFNetworkErrors.cfurlErrorTimedOut.rawValue ||
            nsError.code == CFNetworkErrors.cfurlErrorNetworkConnectionLost.rawValue ||
            nsError.code == CFNetworkErrors.cfurlErrorDNSLookupFailed.rawValue ||
            nsError.code == CFNetworkErrors.cfurlErrorCannotConnectToHost.rawValue ||
            nsError.code == CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue
        {
            var requestBodyString = ""
            
            if let requestBody = request.request?.httpBody,
               let stringData = String(data: requestBody, encoding: .utf8)
            {
                requestBodyString = stringData
            }
            
            print("========= Retry Request 🤔 =========")
            print("||")
            print("|| host : \(request.request?.url?.host ?? "")")
            print("|| path : \(request.request?.url?.path ?? "")")
            print("|| method : \(request.request?.httpMethod ?? "")")
            print("|| header : \(request.request?.headers)")
            if !requestBodyString.isEmpty {
                print("|| body : \(requestBodyString)")
            }
            print("||")
            print("==============================")
        } else {
            print("NetworkRetryHandler not handling.. ")
            completion(.doNotRetry)
        }
    }
    
}
