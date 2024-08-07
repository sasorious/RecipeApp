//
//  RecipeServiceTests.swift
//  RecipeAppTests
//
//  Created by Syafiq A. Sobri on 06/08/2024.
//

import XCTest
import RxSwift
@testable import RecipeApp

class RecipeServiceTests: XCTestCase {

    var recipeService: RecipeService!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        recipeService = RecipeService()
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        recipeService = nil
        disposeBag = nil
        super.tearDown()
    }

    func testGetRecipes() {
        let expectation = self.expectation(description: "Recipes should be fetched")

        recipeService.getRecipes()
            .subscribe(onNext: { recipes in
                XCTAssertFalse(recipes.isEmpty, "Recipes array should not be empty")
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testAddRecipe() {
        let expectation = self.expectation(description: "Recipe should be added")

        let newRecipe = Recipe(title: "Test Recipe", type: "Test Type", ingredients: ["Ingredient1"], steps: ["Step1"], image: nil)

        recipeService.addRecipe(newRecipe)
            .subscribe(onNext: {
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 5, handler: nil)
    }
}
