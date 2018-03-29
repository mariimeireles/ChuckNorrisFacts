//
//  FactWebService.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles on 26/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import RxSwift
import Alamofire
import RxAlamofire

class FactWebService: FactWebServiceProtocol {
    
    private let baseUrl: String
    private let mapper: FactMapper
        
    init() {
        self.baseUrl = "https://api.chucknorris.io/jokes/search?query="
        self.mapper = FactMapper()
    }
    
    func getFacts(_ term: String) -> Observable<[Fact]> {
        let url = self.makeURL(from: self.baseUrl, with: term)
        let infraHandler = InfraHandler()
        let internetConnectionHandler = InternetConnectionHandler()
        
        return RxAlamofire.requestJSON(.get, url)
            .debug()
            .do(onNext: { (response, data) in
                try infraHandler.verifySuccessStatusCode(response)
            })
            .do(onError: { error in
                try internetConnectionHandler.verifyConnection(error)
            })
            .map({ (response, result) -> [Fact] in
                guard let json = result as? JSON else { throw ServiceError.JSONParse(.result) }
                return try self.mapJSONToFacts(json)
            })
    }
    
    func makeURL(from baseUrl: String, with term: String) -> String {
        let url = "\(baseUrl)\(term)"
        let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodedURL ?? url
    }

    private func mapJSONToFacts(_ json: JSON) throws -> [Fact] {
        do {
            let facts = try self.mapper.map(json)
            return facts
        } catch let error {
            let parser = FactMapperErrorParser()
            throw parser.parseError(error)
        }
    }
}

