//
//  AddRecipeView.swift
//  RecipeApp
//
//  Created by Syafiq A. Sobri on 05/08/2024.
//

import SwiftUI
import RxSwift
import RxCocoa

struct AddRecipeView: View {
    @StateObject private var viewModel: RecipeViewModel
    @State private var title: String = ""
    @State private var selectedType: String = ""
    @State private var ingredients: [String] = [""]
    @State private var steps: [String] = [""]
    @State private var image: UIImage? = nil
    @State private var showingImagePicker = false

    init(
        viewModel: RecipeViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Title")) {
                    TextField("Title", text: $title)
                }

                Section(header: Text("Recipe Type")) {
                    Picker("Type", selection: $selectedType) {
                        ForEach(viewModel.recipeTypes, id: \.self) { type in
                            Text(type).tag(type)
                        }
                    }
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
            .navigationTitle("Add Recipe")
            .navigationBarItems(trailing: Button(action: {
                let newRecipe = Recipe(
                    title: title,
                    type: selectedType,
                    ingredients: ingredients,
                    steps: steps,
                    image: image?.pngData()
                )
                viewModel.addRecipe(newRecipe)
                viewModel.saveRecipes()
            }) {
                Text("Save")
            })
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $image)
            }
        }
    }
}
