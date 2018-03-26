//
//  ServiceError.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles on 26/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case JSONParse(JSONParseError)
    case badRequest(BadRequestError)
    case connection(InternetConnectionError)
    case `internalServer`
}

extension ServiceError: Equatable {
    
    static func ==(lhs: ServiceError, rhs: ServiceError) -> Bool {
        switch (lhs, rhs) {
        case (let .JSONParse(error), let .JSONParse(error2)):
            return error == error2
        case (let .badRequest(error), let .badRequest(error2)):
            return error == error2
        case (let .connection(error), let .connection(error2)):
            return error == error2
        case (.internalServer, .internalServer):
            return true
        default:
            return false
        }
    }
}
