//
//  InfraHandler.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles on 23/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

class InfraHandler {
    
    func verifySuccessStatusCode(_ response: HTTPURLResponse) throws {
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            let serviceError = getError(for: response.statusCode)
            throw serviceError
        }
    }
    
    private func getError(for statusCode: Int) -> ServiceError {
        switch statusCode {
        case 400...499:
            let restError = RestError(code: statusCode)
            return .REST(restError)
        default:
            return .internalServer
        }
    }
    
    func mapDataToJSON(_ data: Data) throws -> JSON {
        guard let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let json = result as? JSON else {
                throw ServiceError.JSONParse(.result)
        }
        return json
    }
    

}
