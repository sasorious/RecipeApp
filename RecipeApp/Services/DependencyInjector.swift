//
//  DependencyInjector.swift
//  RecipeApp
//
//  Created by Syafiq A. Sobri on 06/08/2024.
//

import Swinject

class DependencyInjector {
    static let shared = DependencyInjector()
    
    private init() {
        container = Container()
        container.register(AuthService.self) { _ in AuthService() }
        container.register(RecipeService.self) { _ in RecipeService() }
        container.register(RecipeViewModel.self) { resolver in
            RecipeViewModel(recipeService: resolver.resolve(RecipeService.self)!)
        }
    }
    
    let container: Container
}
