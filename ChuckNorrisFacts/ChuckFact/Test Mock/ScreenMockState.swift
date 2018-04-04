//
//  ScreenMockState.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles | Stone on 06/04/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

class ScreenMockState {
    
    private let kState: String
    
    init(stateKey: String = "screen_mock_state") {
        kState = stateKey
    }
    
    func getState(from environment: [String: String]) -> FactWebServiceMock.FactScreenStateMock {
        guard let stateString = environment[kState] else {
            fatalError("There is no state in the environment.")
        }
        return FactWebServiceMock.FactScreenStateMock(state: stateString)
    }
}
