//
//  UITestingTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Mariana Meireles | Stone on 06/04/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

@testable import ChuckNorrisFacts
import Nimble
import XCTest

class UITestingTests: XCTestCase {
    
    private var testing: UITesting!
    private var arguments = ["tst", "--uitesting", "asdsda", "lol"]

    
    override func setUp() {
        super.setUp()
        testing = UITesting(arguments: arguments)
    }
    
    override func tearDown() {
        testing = nil
        super.tearDown()
    }
    
    func test_ShouldBe_RunningInTestMode() {
        let isRunningInTestMode = testing.verifyRunningInTestMode()
        expect(isRunningInTestMode).to(beTrue())
    }
}
