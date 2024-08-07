//
//  RecipeListView.swift
//  RecipeApp
//
//  Created by Syafiq A. Sobri on 05/08/2024.
//

import SwiftUI
import RxSwift
import RxCocoa

struct RecipeListView: View {
    @StateObject private var viewModel: RecipeViewModel
    @StateObject private var authService: AuthService
    private let disposeBag = DisposeBag()

    init(
        viewModel: RecipeViewModel,
        authService: AuthService
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _authService = StateObject(wrappedValue: authService)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.recipes, id: \.id) { recipe in
                    NavigationLink(
                        destination: RecipeDetailView(
                            viewModel: viewModel,
                            recipe: recipe
                        )
                    ) {
                        Text(recipe.title)
                    }
                }
            }
            .navigationTitle("Recipes")
            .navigationBarItems(
                leading: Button("Logout") {
                    authService.logout()
                },
                trailing: NavigationLink(
                    destination: AddRecipeView(
                        viewModel: viewModel
                    )
                ) {
                    Text("Add Recipe")
                }
            )
        }
        .onAppear {
            viewModel.loadRecipes()
        }
    }
}
