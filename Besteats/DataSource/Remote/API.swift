//
//  API.swift
//  Besteats
//
//  Created by BH on 2023/05/19.
//

import Foundation

import Alamofire
import RxSwift

struct APICommon {
    static let host: String = Bundle.main.object(forInfoDictionaryKey: "SERVER_HOST") as! String
}

protocol APIErrorDefinable: Error {
    var httpStatusCode: Int { get }
    var errorMsg: String? { get }
}

struct CommonAPIError: APIErrorDefinable {
    var httpStatusCode: Int
    var errorMsg: String?
}
