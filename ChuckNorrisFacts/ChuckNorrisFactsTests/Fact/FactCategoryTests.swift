//
//  FactCategoryTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Mariana Meireles on 23/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

@testable import ChuckNorrisFacts
import Nimble
import XCTest

final class FactCategoryTests: XCTestCase {
    
    private var validJSON: JSON {
        return [
            "category": nil,
            "icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
            "id": "SvIuvs7cTaCa_eDYPM2KTg",
            "url": "https://api.chucknorris.io/jokes/SvIuvs7cTaCa_eDYPM2KTg",
            "value": "Neil Armstrong finally wore out Chuck Norris' patience."
        ]
    }
    
    private var invalidJSON: JSON {
        return [
            "category": 1,
            "icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
            "id": "tng5xzi5t9syvqaubukycw",
            "url": "https://api.chucknorris.io/jokes/tng5xzi5t9syvqaubukycw",
            "value": "Chuck Norris always knows the EXACT location of Carmen SanDiego."
        ]
    }
    
    func test_shouldReturn_Nil_When_InvalidJSONIsUsed() {
        let categoryNil = Category(json: invalidJSON)
        expect(categoryNil).to(beNil())
    }
    
    func test_shouldReturn_ValidObject_When_ValidJSONIsUsed() {
        let category = Category(json: validJSON)
        expect(category).toNot(beNil())
    }
}

