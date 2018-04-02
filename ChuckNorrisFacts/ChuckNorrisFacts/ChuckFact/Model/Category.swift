//
//  Category.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles | Stone on 15/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

struct Category {
    
    let categories: [String]?
    
}

extension Category {
    
    init?(json: JSON) {
        guard let categories = json["category"] as? [String]? else { return nil }
        self.categories = categories
    }
    
}

