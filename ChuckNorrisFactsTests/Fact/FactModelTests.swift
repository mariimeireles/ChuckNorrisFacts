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
    
    private var factWithMoreThan50Characters: Fact {
        return Fact (categories: nil, message: "Chuck Norris roundhouse kicks don't really kill people. They wipe out their entire existence from the space-time continuum.")
    }
    
    private var factWithLessThan50Characters: Fact {
        return Fact (categories: nil, message: "Chuck Norris can stop the space-time continum")
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
    
    func test_messageFont_ShouldHave_SizeEqualTo_14_When_FactHaveMoreThan50Characters() {
        let model = FactModel(fact: factWithMoreThan50Characters)
        expect(model.messageFont.pointSize).to(equal(14))
    }
    
    func test_messageFont_ShouldHave_SizeEqualTo_16_When_FactHaveLessThan50Characters() {
        let model = FactModel(fact: factWithLessThan50Characters)
        expect(model.messageFont.pointSize).to(equal(16))
    }

}

