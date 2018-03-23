//
//  FactModel.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles on 23/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation
import UIKit

class FactModel {
    
    let message: String
    let category: String
    let categoryBackground: UIColor
    
    init(fact: Fact) {
        
        message = fact.message
        
        if let categories = fact.categories, let category = categories.categories.first {
            self.category = category
            self.categoryBackground = .blue
        } else {
            self.category = "uncategorized"
            self.categoryBackground = .gray
        }
    }
    
}
