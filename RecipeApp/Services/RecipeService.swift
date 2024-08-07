//
//  RecipeService.swift
//  RecipeApp
//
//  Created by Syafiq A. Sobri on 06/08/2024.
//

import Foundation
import RxSwift

class RecipeService {
    private var recipes: [Recipe] = [
        Recipe(
            title: "Pancakes",
            type: "Dessert",
            ingredients: [
                "Flour",
                "Eggs",
                "Milk"
            ],
            steps: [
                "Mix ingredients",
                "Cook on skillet"
            ],
            image: nil
        ),
        Recipe(
            title: "Spaghetti",
            type: "Main Course",
            ingredients: [
                "Spaghetti",
                "Tomato Sauce",
                "Ground Beef"
            ],
            steps: [
                "Cook spaghetti",
                "Prepare sauce",
                "Mix together"
            ],
            image: nil
        )
    ]

    func getRecipes() -> Observable<[Recipe]> {
        // Simulate network or database call
        return Observable.just(recipes).delay(.seconds(1), scheduler: MainScheduler.instance)
    }

    func addRecipe(_ recipe: Recipe) -> Observable<Void> {
        // Simulate adding recipe to database
        recipes.append(recipe)
        return Observable.just(()).delay(.seconds(1), scheduler: MainScheduler.instance)
    }

    func updateRecipe(_ recipe: Recipe) -> Observable<Void> {
        // Simulate updating recipe in database
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index] = recipe
        }
        return Observable.just(()).delay(.seconds(1), scheduler: MainScheduler.instance)
    }

    func deleteRecipe(_ recipe: Recipe) -> Observable<Void> {
        // Simulate deleting recipe from database
        return Observable.just(()).delay(.seconds(1), scheduler: MainScheduler.instance)
    }
}
