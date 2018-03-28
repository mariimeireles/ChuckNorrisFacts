//
//  InternetConnectionHandlerTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Mariana Meireles on 26/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

@testable import ChuckNorrisFacts
import Nimble
import XCTest

class InternetConnectionHandlerTests: XCTestCase {
    
    private var internetConnectionHandler: InternetConnectionHandler!
    private func verifyConnectionMock(_ error: URLError.Code) throws {

        if error == .notConnectedToInternet {
            throw ServiceError.connection(.noConnection)
        } else if error == .timedOut {
            throw ServiceError.connection(.timeout)
        } else {
            throw ServiceError.connection(.other)
        }
    }
    
    private func verifyError(_ error: URLError.Code, equalTo expectedError: InternetConnectionError) {
        expect {
            try self.verifyConnectionMock(error)
            }.to(throwError(closure: { (error: ServiceError) in
                if case let .connection(noConnection) = error {
                    expect(noConnection).to(equal(expectedError))
                } else {
                    fail()
                }
            }))
    }

    override func setUp() {
        super.setUp()
        self.internetConnectionHandler = InternetConnectionHandler()
    }

    override func tearDown() {
        self.internetConnectionHandler = nil
        super.tearDown()
    }
    
    func test_shouldThrow_theSameErrorPassed_when_noConnectionError() {
        let internalServerError = ServiceError.internalServer
        expect {
            try self.internetConnectionHandler.verifyConnection(internalServerError)
            }.to(throwError(closure: { (error: ServiceError) in
                expect(error).to(equal(ServiceError.internalServer))
            }))
    }
    
    func test_shouldThrow_notConnectedError_when_hasNoConnection() {
        let notConnectedToInternet = URLError.notConnectedToInternet
        verifyError(notConnectedToInternet, equalTo: .noConnection)
    }
    
    func test_shouldThrow_timeOutError_when_theRequestWasTimedOut() {
        let timedOut = URLError.timedOut
        verifyError(timedOut, equalTo: .timeout)
    }
    
    func test_shouldThrow_otherError_when_error() {
        let unknown = URLError.unknown
        verifyError(unknown, equalTo: .other)
    }
}

