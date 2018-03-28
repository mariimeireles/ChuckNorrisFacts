//
//  FactURLMaker.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles on 26/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

class FactURLMaker {
    
    func makeURL(from baseUrl: String, with term: String) -> String {
        
        let url = "\(baseUrl)\(term)"
        let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodedURL ?? url
    }
}
