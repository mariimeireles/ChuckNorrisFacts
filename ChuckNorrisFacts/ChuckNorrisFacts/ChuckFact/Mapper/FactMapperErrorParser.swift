//
//  FactMapperErrorParser.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles on 26/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

class FactMapperErrorParser {
    
    func parseError(_ error: Error) -> ServiceError {
        let modelParseError = JSONParseError.model
        return ServiceError.JSONParse(modelParseError)
    }
}
