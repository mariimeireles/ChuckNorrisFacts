//
//  InfraHandlerTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Mariana Meireles on 26/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

@testable import ChuckNorrisFacts
import Nimble
import XCTest

class InfraHandlerTests: XCTestCase {
    
    private var infraHandler: InfraHandler!
    private func getResponseFor(statusCode: Int) -> HTTPURLResponse {
        guard let url = URL(string: "https://www.facebook.com/"), let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            else { fatalError() }
        return response
    }
    
    private func verify(response: HTTPURLResponse, equalTo expectedError: RestError) {
        expect {
            try self.infraHandler.verifySuccessStatusCode(response)
            }.to(throwError { (error: ServiceError) in
                if case let .REST(error) = error {
                    expect(error).to(equal(expectedError))
                }
                else {
                    fail()
                }
            })
    }
    
    override func setUp() {
        super.setUp()
        self.infraHandler = InfraHandler()
    }
    
    override func tearDown() {
        self.infraHandler = nil
        super.tearDown()
    }
    
    func test_shouldThrow_unprocessableEntityError_when_statusCodeIs_422() {
        let response = getResponseFor(statusCode: 422)
        verify(response: response, equalTo: .unprocessableEntity)
    }
    
    func test_shouldThrow_notFoundError_when_statusCodeIs_404() {
        let response = getResponseFor(statusCode: 404)
        verify(response: response, equalTo: .notFound)
    }
    
    func test_shouldThrow_error_when_statusCodeIs_other() {
        let response = getResponseFor(statusCode: 400)
        verify(response: response, equalTo: .other)
    }
    
    func test_shouldThrow_internalServerError_when_statusCodeIs_500() {
        let response = getResponseFor(statusCode: 500)
        expect {
            try self.infraHandler.verifySuccessStatusCode(response)
            }.to(throwError { (error: ServiceError) in
                expect(error).to(equal(ServiceError.internalServer))
            })
    }
    
    func test_shouldNotThrow_error_when_statusCodeIs_success() {
        let response = getResponseFor(statusCode: 200)
        expect {
            try self.infraHandler.verifySuccessStatusCode(response)
            }.toNot(throwError())
    }
}
