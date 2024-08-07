//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by Syafiq A. Sobri on 05/08/2024.
//

import Foundation
import RxSwift
import RxCocoa

class RecipeViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    var recipeTypes = [
        "Breakfast",
        "Lunch",
        "Dinner",
        "Dessert"
    ]

    private let disposeBag = DisposeBag()
    private let recipeService: RecipeService
    
    init(
        recipeService: RecipeService
    ) {
        self.recipeService = recipeService
        loadSavedRecipes()
    }
    
    func loadRecipes() {
        recipeService.getRecipes()
            .subscribe(onNext: { [weak self] recipes in
                self?.recipes = recipes
            })
            .disposed(by: disposeBag)
    }
    
    func addRecipe(_ recipe: Recipe) {
        recipeService.addRecipe(recipe)
            .subscribe(onCompleted: {
                self.loadRecipes()
            })
            .disposed(by: disposeBag)
    }
    
    func updateRecipe(_ recipe: Recipe) {
        recipeService.updateRecipe(recipe)
            .subscribe(onCompleted: {
                self.loadRecipes()
            })
            .disposed(by: disposeBag)
    }
    
    func saveRecipes() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(recipes)
            UserDefaults.standard.set(data, forKey: "savedRecipes")
        } catch {
            print("Failed to save recipes: \(error)")
        }
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        recipes.removeAll { $0.id == recipe.id }
        saveRecipes()
    }
    
    func loadSavedRecipes() {
        guard let data = UserDefaults.standard.data(forKey: "savedRecipes") else { return }
        do {
            let decoder = JSONDecoder()
            let savedRecipes = try decoder.decode([Recipe].self, from: data)
            recipes = savedRecipes
        } catch {
            print("Failed to load recipes: \(error)")
        }
    }
}
