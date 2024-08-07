//
//  Recipe.swift
//  RecipeApp
//
//  Created by Syafiq A. Sobri on 05/08/2024.
//

import Foundation
import UIKit

struct Recipe: Codable, Identifiable {
    let id: UUID
    var title: String
    var type: String
    var ingredients: [String]
    var steps: [String]
    var image: Data?
    
    init(
        title: String,
        type: String,
        ingredients: [String],
        steps: [String],
        image: Data?
    ) {
        self.id = UUID()
        self.title = title
        self.type = type
        self.ingredients = ingredients
        self.steps = steps
        self.image = image
    }
}
