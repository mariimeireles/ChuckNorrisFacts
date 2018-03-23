//
//  FactMapper.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles on 23/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

class FactMapper {
    
    
    enum FactError: Error {
        case invalidJSON
    }
    
    func map(_ json: JSON) throws -> [Fact] {
        
        guard let jsonList = json["result"] as? [JSON] else {
            throw FactError.invalidJSON
        }
        var facts: [Fact] = []
        
        for json in jsonList {
            let fact = Fact(json: json)
            facts.append(fact)
        }
        return facts
    }
    
}

extension FactMapper.FactError: Equatable {
    
    static func ==(lhs: FactMapper.FactError, rhs: FactMapper.FactError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidJSON, .invalidJSON):
            return true
        }
    }
    
}

