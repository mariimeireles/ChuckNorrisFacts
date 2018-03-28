//
//  BadRequestError.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles on 23/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

enum BadRequestError {
    case notFound
    case unprocessableEntity
    case other
    
    init(code: Int) {
        switch code {
        case 404:
            self = .notFound
        case 422:
            self = .unprocessableEntity
        default:
            self = .other
        }
    }
}
