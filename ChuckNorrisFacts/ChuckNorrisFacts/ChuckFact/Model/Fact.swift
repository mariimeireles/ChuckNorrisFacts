//
//  Fact.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles | Stone on 15/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

struct Fact {
    
    let categories: Category?
    let message: String
    
}

extension Fact {
    
    init(json: JSON) {
        let category = Category(json: json)
        let message = json["value"] as? String
        
        self.categories = category
        self.message = message!
    }

}
