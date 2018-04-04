//
//  UITesting.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles | Stone on 06/04/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

class UITesting {
    
    private let arguments: [String]
    private let testMode = "--uitesting"
    
    init(arguments: [String]) {
        self.arguments = arguments
    }
    
    func verifyRunningInTestMode() -> Bool {
        return arguments.contains(testMode)
    }
}
