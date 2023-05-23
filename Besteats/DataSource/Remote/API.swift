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

enum Search { }

protocol APIErrorDefinable: Error {
    var httpStatusCode: Int { get }
    var errorMsg: String? { get }
}

struct CommonAPIError: APIErrorDefinable {
    var httpStatusCode: Int
    var errorMsg: String?
}

protocol APIDefinition {
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var parameters: BestEatsParameters? { get }
    var method: HTTPMethod { get }
}

extension APIDefinition {
    static var rx: Reactive<Self>.Type {
        get { Reactive<Self>.self }
        set {}
    }
    
    var rx: Reactive<Self> {
        get { Reactive(self) }
        set {}
    }
}
