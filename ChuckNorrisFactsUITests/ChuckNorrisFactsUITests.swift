//
//  ChuckNorrisFactsUITests.swift
//  ChuckNorrisFactsUITests
//
//  Created by Mariana Meireles | Stone on 14/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import XCTest
import Nimble

class ChuckNorrisFactsUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var screen: FactScreenState!
    
    private func setScreenState(to state: String) {
        app.launchEnvironment.updateValue(state, forKey: "screen_mock_state")
    }
    
    private func searchSomeFactAndWaitFor(_ state: String) {
        setScreenState(to: state)
        app.launch()
        screen.textField.tap()
        screen.textField.typeText("A fact")
        screen.searchButton.tap()
    }
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        screen = FactScreenState(app: app)
    }
    
    override func tearDown() {
        screen = nil
        app = nil
        super.tearDown()
    }
    
    func test_TextField_Should_BeEnabled_When_AppStarts() {
        setScreenState(to: "success")
        app.launch()
        expect(self.screen.textField.isEnabled).to(beTrue())
    }

    func test_SearchButton_Should_BeDisabled_When_AppStarts() {
        setScreenState(to: "success")
        app.launch()
        expect(self.screen.searchButton.isEnabled).to(beFalse())
    }

    func test_SearchSomeFactWith_Success_AndShouldShow_AListWithTwoFacts() {
        searchSomeFactAndWaitFor("success")
        expect(self.screen.tableView.cells.count).toEventually(equal(2), timeout: 1)
    }

    func test_SearchSomeFactWith_NoConnection_AndShow_NoConnectionAlert() {
        searchSomeFactAndWaitFor("noConnection")
        expect(self.screen.noConnection.exists).toEventually(beTrue(), timeout: 2)
    }

    func test_SearchSomeFactWith_SuccessWithEmptyResult_AndShow_NoResultAlert() {
        searchSomeFactAndWaitFor("successWithoutFact")
        expect(self.screen.noResults.exists).toEventually(beTrue(), timeout: 1)
    }

    func test_SearchSomeFactWith_InvalidTerm_AndShow_InvalidTermAlert() {
        searchSomeFactAndWaitFor("invalidTerm")
        expect(self.screen.invalidTerm.exists).toEventually(beTrue(), timeout: 1)
    }

    func test_SearchSomeFactWith_ServerError_AndShow_ServerErrorAlert() {
        searchSomeFactAndWaitFor("serverError")
        expect(self.screen.serverError.exists).toEventually(beTrue(), timeout: 1)
    }

    func test_SearchSomeFactWith_InternalError_AndShow_InternalErrorAlert() {
        searchSomeFactAndWaitFor("internal")
        expect(self.screen.internalError.exists).toEventually(beTrue(), timeout: 1)
    }
    
}

extension ChuckNorrisFactsUITests {
    
    struct FactScreenState {
        
        let textField: XCUIElement
        let searchButton: XCUIElement
        let tableView: XCUIElement
        let noConnection: XCUIElement
        let noResults: XCUIElement
        let invalidTerm: XCUIElement
        let serverError: XCUIElement
        let internalError: XCUIElement
        
        init(app: XCUIApplication) {
            textField = app.textFields["FactTextField"]
            searchButton = app.buttons["SearchButton"]
            tableView = app.tables["FactTableView"]
            noConnection = app.alerts.element.staticTexts["It seems that your not connected to the internet. Check your connection or try again"]
            noResults = app.alerts.element.staticTexts["We couldn't find a result for your search. Try another fact"]
            invalidTerm = app.alerts.element.staticTexts["This is not a valid term, try another one"]
            serverError = app.alerts.element.staticTexts["An error occurred please try again later"]
            internalError = app.alerts.element.staticTexts["An error occurred please try again later"]
        }
    }
}
