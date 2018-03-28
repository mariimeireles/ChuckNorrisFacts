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
    
    private var urlMaker: FactURLMaker!
    
    override func setUp() {
        super.setUp()
        self.urlMaker = FactURLMaker()
    }
    
    override func tearDown() {
        self.urlMaker = nil
        super.tearDown()
    }
    
    func test_should_encodeURL() {
        let baseUrl = "https://api.chucknorris.io/jokes/search?query="
        let term = "black pánts"
        let url = self.urlMaker.makeURL(from: baseUrl, with: term)
        let encodedURL = "https://api.chucknorris.io/jokes/search?query=black%20p%C3%A1nts"
        expect(url).to(equal(encodedURL))
    }
    
    func test_should_concatURL() {
        let baseUrl = "https://api.chucknorris.io/jokes/search?query="
        let term = "cale"
        let url = self.urlMaker.makeURL(from: baseUrl, with: term)
        expect(url).to(equal(baseUrl + term))
    }

}

