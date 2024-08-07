//
//  ContentView.swift
//  RecipeApp
//
//  Created by Syafiq A. Sobri on 05/08/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authService: AuthService

    var body: some View {
        Group {
            if authService.isAuthenticated {
                RecipeListView(viewModel: RecipeViewModel(recipeService: RecipeService()), authService: authService)
            } else {
                LoginView()
            }
        }
    }
}
