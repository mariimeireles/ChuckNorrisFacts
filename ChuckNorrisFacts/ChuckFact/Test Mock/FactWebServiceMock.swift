//
//  FactWebServiceMock.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles on 02/04/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation
import RxSwift

class FactWebServiceMock: FactWebServiceProtocol {

    private var response = HTTPURLResponse()
    private var facts: [Fact] = []
    private var result: Data = Data()
    private var isConnectionError = false
    var expectedSuccessWithFacts: [FactModel] {
        return facts.map { FactModel(fact: $0) }
    }
    var expectedSuccessWithEmptyFacts: [FactModel] {
        return []
    }
    
    init(desired state: FactScreenStateMock = .unknown) {
        configMock(to: state)
    }
    
    func getFacts(_ term: String) -> Observable<[Fact]> {
        let handler = InfraHandler()
        
        return Observable.just((response, result))
            .do(onNext: { (response, data) in
                try handler.verifySuccessStatusCode(response)
            })
            .do(onError: { [unowned self] error in
                let error = self.verifyIsInternetError(error)
                let handler = InternetConnectionHandlerMock()
                try handler.verify(error)
            })
            .map({ [unowned self] (_, data) -> [Fact] in
                let json = try handler.mapDataToJSON(data)
                return try self.mapJSONToFacts(json)
            })
    }
    
    private func configMock(to state: FactScreenStateMock) {
        isConnectionError = false
        switch state {
        case .success:
            facts = someFacts
            result = mapJSONToData(someFactsInJSON)
            setResponseForStatus(code: 200)
        case .successWithoutFact:
            fillWithEmptyResult()
            setResponseForStatus(code: 200)
        case .noConnection:
            isConnectionError = true
        case .noResults:
            setResponseForStatus(code: 422)
        case .invalidTerm:
            setResponseForStatus(code: 404)
        case .serverError:
            setResponseForStatus(code: 500)
        case .unknown:
            setResponseForStatus(code: 400)
        }
    }
    
    private func mapJSONToFacts(_ json: JSON) throws -> [Fact] {
        do {
            let mapper = FactMapper()
            let facts = try mapper.map(json)
            return facts
        } catch let error {
            let parser = FactMapperErrorParser()
            throw parser.parseError(error)
        }
    }
    
    private var someFacts: [Fact] {
        return [
            Fact(categories: nil, message: "Chuck Norris got the new Galaxy Foamposites for free."),
            Fact(categories: Category(categories: ["explicit"]), message: "Chuck Norris once challenged Lance Armstrong in a \"Who has more testicles?\" contest. Chuck Norris won by 5.")
        ]
    }
    
    private var someFactsInJSON: JSON {
        return [
            "total": 2,
            "result": [
                [
                    "icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
                    "id": "tng5xzi5t9syvqaubukycw",
                    "url": "https://api.chucknorris.io/jokes/tng5xzi5t9syvqaubukycw",
                    "value": "Chuck Norris always knows the EXACT location of Carmen SanDiego."
                ],
                [
                    "category": ["Car"],
                    "icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
                    "id": "DuhjnnJCQmKAeMECnYTJuA",
                    "url": "https://api.chucknorris.io/jokes/DuhjnnJCQmKAeMECnYTJuA",
                    "value": "Jack in the Box's do not work around Chuck Norris. They know better than to attempt to scare Chuck Norris"
                ]
            ]
        ]
    }
    
    private func mapJSONToData(_ json: JSON) -> Data {
        return try! JSONSerialization.data(withJSONObject: json, options: [])
    }
    
    private func setResponseForStatus(code: Int) {
        let url = URL(string: "https://www.google.com.br")!
        response = HTTPURLResponse(url: url, statusCode: code, httpVersion: nil, headerFields: nil)!
    }
    
    private func fillWithEmptyResult() {
        let emptyJSON: JSON = [
            "total": 0,
            "result": []
        ]
        result = mapJSONToData(emptyJSON)
    }
    
    private func verifyIsInternetError(_ error: Error) -> Error {
        if self.isConnectionError {
            return URLError.notConnectedToInternet
        }
        else {
            return error
        }
    }
    
    enum FactScreenStateMock: String {
        case success
        case successWithoutFact
        case noConnection
        case noResults
        case invalidTerm
        case serverError
        case unknown
        
        init(state: String) {
            switch state {
            case FactScreenStateMock.success.rawValue:
                self = .success
            case FactScreenStateMock.successWithoutFact.rawValue:
                self = .successWithoutFact
            case FactScreenStateMock.noConnection.rawValue:
                self = .noConnection
            case FactScreenStateMock.noResults.rawValue:
                self = .noResults
            case FactScreenStateMock.invalidTerm.rawValue:
                self = .invalidTerm
            case FactScreenStateMock.serverError.rawValue:
                self = .serverError
            case FactScreenStateMock.unknown.rawValue:
                self = .unknown
            default:
                self = .unknown
            }
        }
    }
}

extension URLError.Code: Error {}

