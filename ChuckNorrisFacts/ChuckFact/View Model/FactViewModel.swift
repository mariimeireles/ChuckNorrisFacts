//
//  FactViewModel.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles on 02/04/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import Foundation
import RxSwift

class FactViewModel {
    
    private let webService: FactWebServiceProtocol
    
    init(webService: FactWebServiceProtocol) {
        self.webService = webService
    }
    
    func search(for term: String) -> Observable<FactScreenState> {
        return getScreenState(from: term)
            .startWith(.loading)
    }
    
    func getScreenState(from term: String) -> Observable<FactScreenState> {
        return self.webService.getFacts(term)
            .map { [unowned self] facts in
                self.mapFactsToSuccessState(facts)
            }
            .catchError { [unowned self] (error) -> Observable<FactScreenState> in
                let state = self.mapErrorToScreenState(error)
                return Observable.just(state)
        }
    }
    
    func mapFactsToSuccessState(_ facts: [Fact]) -> FactScreenState {
        let facts = facts.map {
            FactModel(fact: $0)
        }
        if facts.isEmpty {
            return FactScreenState.successWithoutFact
        }
        return FactScreenState.success(facts)
    }
    
    func mapErrorToScreenState(_ error: Error) -> FactScreenState {
        guard let serviceError = error as? ServiceError else {
            return FactScreenState.failure(.unknown)
        }
        switch serviceError {
        case .JSONParse:
            return FactScreenState.failure(.unknown)
        case let .REST(error):
            return FactScreenState(restError: error)
        case .connection:
            return FactScreenState.failure(.connection)
        case .internalServerError:
            return FactScreenState.failure(.serverError)
        }
    }

}
