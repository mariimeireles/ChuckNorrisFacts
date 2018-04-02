//
//  RESTError.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles on 23/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

enum RESTError {
    
    case notFound
    case unprocessableEntity
    case serverError
    case other
    
    init(code: Int) {
        switch code {
        case 404:
            self = .notFound
        case 422:
            self = .unprocessableEntity
        case 500...513:
            self = .serverError
        default:
            self = .other
        }
    }
}
