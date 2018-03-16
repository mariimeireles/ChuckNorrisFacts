//
//  Fact.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles | Stone on 15/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

struct Fact {
    
    let category: Category?
    let message: String
    
    init(json: JSON) {
        
        let category = Category(json: json)
        let message = json["value"] as? String
        
        self.category = category
        self.message = message!
    }
    
}
