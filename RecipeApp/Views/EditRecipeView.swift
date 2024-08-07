//
//  EditRecipeView.swift
//  RecipeApp
//
//  Created by Syafiq A. Sobri on 05/08/2024.
//

import SwiftUI

struct EditRecipeView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @Binding var recipe: Recipe
    @State private var title: String = ""
    @State private var type: String = ""
    @State private var ingredients: [String] = []
    @State private var steps: [String] = []
    @State private var image: UIImage? = nil
    @State private var showingImagePicker = false

    init(viewModel: RecipeViewModel, recipe: Binding<Recipe>) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        _recipe = recipe
        _title = State(initialValue: recipe.wrappedValue.title)
        _type = State(initialValue: recipe.wrappedValue.type)
        _ingredients = State(initialValue: recipe.wrappedValue.ingredients)
        _steps = State(initialValue: recipe.wrappedValue.steps)
    }

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Title", text: $title)
            }

            Section(header: Text("Type")) {
                TextField("Type", text: $type)
            }

            Section(header: Text("Ingredients")) {
                ForEach(0..<ingredients.count, id: \.self) { index in
                    TextField("Ingredient \(index + 1)", text: $ingredients[index])
                }
                Button(action: {
                    ingredients.append("")
                }) {
                    Text("Add Ingredient")
                }
            }

            Section(header: Text("Steps")) {
                ForEach(0..<steps.count, id: \.self) { index in
                    TextField("Step \(index + 1)", text: $steps[index])
                }
                Button(action: {
                    steps.append("")
                }) {
                    Text("Add Step")
                }
            }

            Section {
                Button(action: {
                    showingImagePicker = true
                }) {
                    Text("Choose Image")
                }

                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .navigationTitle("Edit Recipe")
        .navigationBarItems(trailing: Button("Save") {
            recipe.title = title
            recipe.type = type
            recipe.ingredients = ingredients
            recipe.steps = steps
            recipe.image = image?.pngData()
            viewModel.updateRecipe(recipe)
        })
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $image)
        }
    }
}
