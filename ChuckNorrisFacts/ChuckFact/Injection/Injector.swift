//
//  Injector.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles | Stone on 10/04/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

class Injector {
    
    private let arguments: [String]
    private let processInfo: ProcessInfo
    
    init(with arguments: [String], and processInfo: ProcessInfo) {
        self.arguments = arguments
        self.processInfo = processInfo
    }
    
    func viewModel() -> FactViewModel {
        return FactViewModel(webService: webService())
    }
    
    func webService() -> FactWebServiceProtocol {
        if launcMode().verifyRunningInTestMode() {
            let mockState = ScreenMockState()
            let state = mockState.getState(from: processInfo.environment)
            return FactWebServiceMock(desired: state)
        }
        return FactWebService()
    }
    
    func launcMode() -> UITesting {
        return UITesting(arguments: arguments)
    }
}
