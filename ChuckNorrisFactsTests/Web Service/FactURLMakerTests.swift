//
//  FactURLMakerTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Mariana Meireles on 26/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

@testable import ChuckNorrisFacts
import Nimble
import XCTest

class FactURLMakerTests: XCTestCase {
    
    private var factWebService: FactWebService!
    
    override func setUp() {
        super.setUp()
        self.factWebService = FactWebService()
    }
    
    override func tearDown() {
        self.factWebService = nil
        super.tearDown()
    }
    
    func test_should_encodeURL() {
        let baseUrl = "https://api.chucknorris.io/jokes/search?query="
        let term = "black pánts"
        let url = self.factWebService.makeURL(from: baseUrl, with: term)
        let encodedURL = "https://api.chucknorris.io/jokes/search?query=black%20p%C3%A1nts"
        expect(url).to(equal(encodedURL))
    }
    
    func test_should_concatURL() {
        let baseUrl = "https://api.chucknorris.io/jokes/search?query="
        let term = "cale"
        let url = self.factWebService.makeURL(from: baseUrl, with: term)
        expect(url).to(equal(baseUrl + term))
    }

}

