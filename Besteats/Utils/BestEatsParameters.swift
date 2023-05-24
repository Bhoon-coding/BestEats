//
//  BestEatsParameters.swift
//  Besteats
//
//  Created by BH on 2023/05/19.
//

import Foundation

import Alamofire

extension Encodable {
    func encode() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
            throw NSError()
        }
        
        return dictionary
    }
}

struct Code {
    let key: CodeKey
    let value: Codable?
}

enum CodeKey: String, CodingKey {
    case query
    case clientId = "client_id"
    
    
}

public class BestEatsParameters {
    private var params: [String: Codable?] = [:]
    
    func append(_ code: Code) {
        params[code.key.rawValue] = code.value
    }
    
    func toDictionary() -> Alamofire.Parameters {
        var parameters = Alamofire.Parameters()
        params.forEach { key, value in
            
            if let dictionaryValue = try? value?.encode() {
                parameters[key] = dictionaryValue
            } else {
                parameters[key] = value
            }
        }
        
        return parameters
    }
}
