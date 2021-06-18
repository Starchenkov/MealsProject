//
//  MealModel.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 12.06.2021.
//

import Foundation

struct MealModel
{
    let holder: UUID
    let id: String
    let name: String
    let category: String
    let area: String
    let instructions: String
    let image: String
    let youtubeUrl: String?
    let ingredients: String
    let sourceUrl: String?
    var inFavorite: Bool
    
    init(holder: UUID, id: String, name: String, category: String, area: String, instructions: String, image: String, youtubeUrl: String?, ingredients: String, sourceUrl: String?) {
        self.holder = holder
        self.id = id
        self.name = name
        self.category = category
        self.area = area
        self.instructions = instructions
        self.image = image
        self.youtubeUrl = youtubeUrl
        self.ingredients = ingredients
        self.sourceUrl = sourceUrl
        self.inFavorite = false
    }
    
    init?(meal: Meal) {
        guard let holder = meal.holder?.uid,
              let id = meal.uid,
              let name = meal.name,
              let category = meal.category,
              let area = meal.area,
              let instructions = meal.instructions,
              let image = meal.imageURL,
              let ingredients = meal.ingredients else { return nil }
        self.holder = holder
        self.id = id
        self.name = name
        self.category = category
        self.area = area
        self.instructions = instructions
        self.image = image
        self.youtubeUrl = meal.youtubeURL
        self.ingredients = ingredients
        self.sourceUrl = meal.sourceURL
        self.inFavorite = true
    }
}
