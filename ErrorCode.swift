//
//  ErrorCode.swift
//  Besteats
//
//  Created by BH on 2023/05/19.
//

import Foundation

import Alamofire

enum BestEatsError: Error {
    
    enum NetworkError: Error {
        /// timout error
        case networkTimeout
        /// network lost
        case networkUnavailable
        /// 잘못된 URL
        case invalidURL
        /// apiError
        case apiError(definition: APIErrorDefinable)
        /// undefined
        case undefined(rawCode: Int)
        /// unknown
        case unknown(afError: AFError)
        /// empty Data
        case emptyData
        /// parsingFail
        case parsingFail
        
        var messageDescription: String {
            switch self {
            case .networkTimeout:
                return "네트워크가 불안정 합니다. 확인 후 다시 시도해주세요."
            case .networkUnavailable:
                return "네트워크 연결이 불안정합니다. 네트워크가 연결 되었는지 확인 해주세요."
            case .invalidURL:
                return "유효하지 않은 URL 입니다."
            case .apiError(definition: let definition):
                return "\(definition.errorMsg)"
            case .undefined(rawCode: let rawCode):
                return "알 수 없는 오류 입니다. 코드번호: \(rawCode)"
            case .unknown(afError: let afError):
                return "알 수 없는 오류 입니다. \(afError.localizedDescription)"
            case .emptyData:
                return "데이터가 없습니다."
            case .parsingFail:
                return "파싱 실패"
            }
        }
        
    }
}
