//
//  FactScreenState.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles on 02/04/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation

enum FactScreenState {
    
    case loading
    case success([FactModel])
    case successWithoutFact
    case failure(FactScreenErrorType)
    
    init(restError: RESTError) {
        switch restError {
        case .unprocessableEntity:
            self = .failure(.noResults)
        case .notFound:
            self =  .failure(.invalidTerm)
        case .serverError:
            self = .failure(.serverError)
        case .other:
            self = .failure(.unknown)

        }
    }
}

extension FactScreenState: Equatable {
    
    static func ==(lhs: FactScreenState, rhs: FactScreenState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case let (.failure(error), .failure(error2)):
            return error == error2
        case let (.success(facts), .success(facts2)):
            return facts == facts2
        case (.successWithoutFact, .successWithoutFact):
            return true
        default:
            return false
        }
    }
}
