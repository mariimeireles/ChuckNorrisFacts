//
//  ScreenMockStateTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Mariana Meireles | Stone on 06/04/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

@testable import ChuckNorrisFacts
import Nimble
import XCTest

final class ScreenMockStateTests: XCTestCase {
    
    private var mockState: ScreenMockState!
    
    private func getEnvironment(for state: FactWebServiceMock.FactScreenStateMock) -> [String: String] {
        return ["screen_mock_state": state.rawValue]
    }
    
    private func verifyEnvironment(for expectedState: FactWebServiceMock.FactScreenStateMock) {
        let environment = getEnvironment(for: expectedState)
        let result = mockState.getState(from: environment)
        expect(result) == expectedState
    }
    
    override func setUp() {
        super.setUp()
        mockState = ScreenMockState()
    }
    
    override func tearDown() {
        mockState = nil
        super.tearDown()
    }
    
    func test_State_ShouldBe_Success() {
        verifyEnvironment(for: .success)
    }
    
    func test_State_ShouldBe_SuccessWithEmptyResult() {
        verifyEnvironment(for: .successWithoutFact)
    }
    
    func test_State_ShouldBe_NoResultsForTerm() {
        verifyEnvironment(for: .noResults)
    }
    
    func test_State_ShouldBe_InvalidTerm() {
        verifyEnvironment(for: .invalidTerm)
    }
    
    func test_State_ShouldBe_NoConnection() {
        verifyEnvironment(for: .noConnection)
    }
    
    func test_State_ShouldBe_Internal() {
        verifyEnvironment(for: .unknown)
    }
}

