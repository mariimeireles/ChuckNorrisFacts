//
//  FactMapperTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Mariana Meireles on 23/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

@testable import ChuckNorrisFacts
import Nimble
import XCTest

final class FactMapperTests: XCTestCase {
    
    private var mapper: FactMapper!
    private var validJSON: JSON {
        return [
            "total": 1,
            "result": [
                [
                    "category": ["explicit"],
                    "icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
                    "id": "axtqqerhrm2lredluq1suw",
                    "url": "https://api.chucknorris.io/jokes/tng5xzi5t9syvqaubukycw",
                    "value": "Chuck Norris once challenged Lance Armstrong in a \"Who has more testicles?\" contest. Chuck Norris won by 5."
                ]
            ]
        ]
    }
    
    private var invalidJSON: JSON {
        return [
            "total": 1,
            "resultt": [
                [
                    "category": ["dev"],
                    "icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
                    "id": "2nd0jxvvqnwpvagswww-lg",
                    "url": "https://api.chucknorris.io/jokes/2nd0jxvvqnwpvagswww-lg",
                    "value": "Chuck Norris insists on strongly-typed programming languages."
                ]
            ]
        ]
    }
    
    override func setUp() {
        super.setUp()
        mapper = FactMapper()
    }
    
    override func tearDown() {
        mapper = nil
        super.tearDown()
    }
    
    func test_shouldThrow_ErrorWhen_invalidJSON() {
        expect {
            try self.mapper.map(self.invalidJSON)
            }.to(throwError { (error: FactMapper.FactError) in
                expect(error).to(equal(FactMapper.FactError.invalidJSON))
            })
    }
    
    func test_shouldNot_ThrowError_When_ValidJSONIsUsed() {
        expect {
            try self.mapper.map(self.validJSON)
            }.toNot(throwError())
    }
}
