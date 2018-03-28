//
//  FactMapperErrorParserTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Mariana Meireles on 26/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

@testable import ChuckNorrisFacts
import Nimble
import XCTest

class FactMapperErrorParserTests: XCTestCase {
    
    private var errorParser: FactMapperErrorParser!
    
    override func setUp() {
        super.setUp()
        self.errorParser = FactMapperErrorParser()
    }
    
    override func tearDown() {
        self.errorParser = nil
        super.tearDown()
    }
    
    func test_serviceError_shouldBe_modelParse() {
        let invalidJSONError: Error = FactMapper.FactError.invalidJSON
        let serviceError = self.errorParser.parseError(invalidJSONError)
        if case let .JSONParse(error) = serviceError {
            expect(error).to(equal(JSONParseError.model))
        }
    }
}

