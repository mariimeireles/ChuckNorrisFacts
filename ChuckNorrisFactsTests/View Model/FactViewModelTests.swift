//
//  FactViewModelTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Mariana Meireles on 02/04/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

@testable import ChuckNorrisFacts
import Nimble
import RxSwift
import RxTest
import XCTest

class FactViewModelTests: XCTestCase {
    
    private var disposeBag: DisposeBag!
    private var webServiceMock: FactWebServiceMock!
    private var viewModel: FactViewModel!
    private let scheduler = TestScheduler(initialClock: 0)
    private var observer: TestableObserver<FactScreenState>!
    private func setServiceState(for state: FactWebServiceMock.FactScreenStateMock = .success) {
        webServiceMock = FactWebServiceMock(desired: state)
        viewModel = FactViewModel(webService: webServiceMock)
    }
    private func searchForTerm() {
        viewModel.search(for: "some term")
            .subscribe(observer)
            .disposed(by: disposeBag)
        scheduler.start()
    }
    private func compareResult(with expectedResult: [Recorded<Event<FactScreenState>>]) -> Bool {
        let getResult = observer.events
        return getResult == expectedResult
    }
    
    override func setUp() {
        super.setUp()
        observer = scheduler.createObserver(FactScreenState.self)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_initialState_shouldBe_loading() {
        setServiceState()
        searchForTerm()
        let getState = observer.events.first!
        let expectedState = onNext(expect: FactScreenState.loading)
        let equalState = getState == expectedState
        expect(equalState).to(beTrue())
    }
    
    func test_state_shouldBe_successWithEmptyResult() {
        setServiceState(for: .successWithoutFact)
        searchForTerm()
        let expectedResult = [
            onNext(expect: FactScreenState.loading),
            onNext(expect: FactScreenState.successWithoutFact),
            completed()
        ]
        let isPipelineEqual = compareResult(with: expectedResult)
        expect(isPipelineEqual).to(beTrue())
    }
    
    func test_state_shouldBe_failure_noResults() {
        setServiceState(for: .noResults)
        searchForTerm()
        let expectedResult = [
            onNext(expect: FactScreenState.loading),
            onNext(expect: FactScreenState.failure(.noResults)),
            completed()
        ]
        let isPipelineEqual = compareResult(with: expectedResult)
        expect(isPipelineEqual).to(beTrue())
    }
    
    func test_state_shouldBe_failure_invalidTerm() {
        setServiceState(for: .invalidTerm)
        searchForTerm()
        let expectedResult = [
            onNext(expect: FactScreenState.loading),
            onNext(expect: FactScreenState.failure(.invalidTerm)),
            completed()
        ]
        let isPipelineEqual = compareResult(with: expectedResult)
        expect(isPipelineEqual).to(beTrue())
    }
    
    func test_state_shouldBe_failure_serverError() {
        setServiceState(for: .serverError)
        searchForTerm()
        let expectedResult = [
            onNext(expect: FactScreenState.loading),
            onNext(expect: FactScreenState.failure(.serverError)),
            completed()
        ]
        let isPipelineEqual = compareResult(with: expectedResult)
        expect(isPipelineEqual).to(beTrue())
    }
    
    func test_state_shouldBe_failure_internalError() {
        setServiceState(for: .unknown)
        searchForTerm()
        let expectedResult = [
            onNext(expect: FactScreenState.loading),
            onNext(expect: FactScreenState.failure(.unknown)),
            completed()
        ]
        let isPipelineEqual = compareResult(with: expectedResult)
        expect(isPipelineEqual).to(beTrue())
    }
}
