//
//  RecipeDetailView.swift
//  RecipeApp
//
//  Created by Syafiq A. Sobri on 05/08/2024.
//

import SwiftUI

struct RecipeDetailView: View {
    @ObservedObject var viewModel: RecipeViewModel
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(recipe.title)
                .font(.largeTitle)
                .padding(.bottom)

            Text("Type: \(recipe.type)")
                .font(.headline)
                .padding(.bottom)

            Text("Ingredients")
                .font(.headline)

            ForEach(recipe.ingredients, id: \.self) { ingredient in
                Text("- \(ingredient)")
            }

            Text("Steps")
                .font(.headline)
                .padding(.top)

            ForEach(recipe.steps, id: \.self) { step in
                Text(step)
            }

            if let imageData = recipe.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .padding(.top)
            }

            Spacer()

            HStack {
                Button(action: {
                    viewModel.deleteRecipe(recipe)
                }) {
                    Text("Delete")
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }

                Spacer()

                NavigationLink(destination: EditRecipeView(viewModel: viewModel, recipe: .constant(recipe))) {
                    Text("Edit")
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            .padding(.top)
        }
        .padding()
        .navigationTitle("Recipe Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
