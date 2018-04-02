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

class FactCategoryTests: XCTestCase {
    
    private var validJSON: JSON {
        return [
            "category": ["Money"],
            "icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
            "id": "SvIuvs7cTaCa_eDYPM2KTg",
            "url": "https://api.chucknorris.io/jokes/SvIuvs7cTaCa_eDYPM2KTg",
            "value": "Neil Armstrong finally wore out Chuck Norris' patience."
        ]
    }
    
    private var invalidJSON: JSON {
        return [
            "category": "Car",
            "icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
            "id": "tng5xzi5t9syvqaubukycw",
            "url": "https://api.chucknorris.io/jokes/tng5xzi5t9syvqaubukycw",
            "value": "Chuck Norris always knows the EXACT location of Carmen SanDiego."
        ]
    }
    
    func test_shouldReturn_nil_whenInvalidJSON() {
        let categoryNil = Category(json: invalidJSON)
        expect(categoryNil).to(beNil())
    }
    
    func test_shouldReturn_validObject_whenValidJSON() {
        let category = Category(json: validJSON)
        expect(category).toNot(beNil())
    }
}

