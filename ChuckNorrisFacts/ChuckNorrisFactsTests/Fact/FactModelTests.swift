//
//  FactModelTests.swift
//  ChuckNorrisFactsTests
//
//  Created by Mariana Meireles on 23/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

@testable import ChuckNorrisFacts
import Nimble
import XCTest

class FactModelTests: XCTestCase {
    
    private var modelWithoutCategory: FactModel!
    private var modelWithCategory: FactModel!
    
    private var factWithoutCategory: Fact {
        return Fact(categories: nil, message: "Chuck Norris got the new Galaxy Foamposites for free.")
    }
    
    private var factWithCategory: Fact {
        return Fact(categories: Category(categories: ["explicit"]), message: "Chuck Norris once challenged Lance Armstrong in a \"Who has more testicles?\" contest. Chuck Norris won by 5.")
    }
    
    override func setUp() {
        super.setUp()
        modelWithoutCategory = FactModel(fact: factWithoutCategory)
        modelWithCategory = FactModel(fact: factWithCategory)
    }
    
    override func tearDown() {
        modelWithoutCategory = nil
        modelWithCategory = nil
        super.tearDown()
    }
    
    func test_categoryText_whenCategoryIsNil() {
        expect(self.modelWithoutCategory.category).to(equal("uncategorized"))
    }
    
    func test_categoryBackgroundShouldBe_gray_whenCategoryIsNil() {
        expect(self.modelWithoutCategory.categoryBackground).to(equal(UIColor.gray))
    }
    
    func test_categoryBackgroundShouldBe_blue_whenHaveCategory() {
        expect(self.modelWithCategory.categoryBackground).to(equal(UIColor.blue))
    }

}

