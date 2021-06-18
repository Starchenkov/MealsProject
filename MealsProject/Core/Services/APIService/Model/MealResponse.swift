//
//  MealResponse.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 12.06.2021.
//

import Foundation

struct MealsResponse: Decodable
{
    let meals: [MealResponse]
}

struct MealResponse: Decodable
{
    private enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case imageURL = "strMealThumb"
        case youtubeURL = "strYoutube"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
        case measure16 = "strMeasure16"
        case measure17 = "strMeasure17"
        case measure18 = "strMeasure18"
        case measure19 = "strMeasure19"
        case measure20 = "strMeasure20"
        case sourceUrl = "strSource"
    }
    
    let id: String
    let name: String
    let category: String
    let area: String
    let instructions: String
    let imageURL: String
    let youtubeURL: String?
    let sourceUrl: String?
    var ingredients: [String]
    var measurements: [String]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(String.self, forKey: .category)
        self.area = try container.decode(String.self, forKey: .area)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
        self.youtubeURL = try container.decode(String.self, forKey: .youtubeURL)
        self.sourceUrl = try container.decode(String.self, forKey: .sourceUrl)
        
        self.ingredients = []
        self.measurements = []
        
        for index in 1...20 {
            let ingredientString = "strIngredient\(index)"
            let measureString = "strMeasure\(index)"
            
            guard let ingredientCodingKey = CodingKeys(rawValue: ingredientString) else { return }
            guard let measureCodingKey = CodingKeys(rawValue: measureString) else { return }
            
            let ingredient = try container.decode(String.self, forKey: ingredientCodingKey)
            let measure = try container.decode(String.self, forKey: measureCodingKey)
            
            if ingredient.isEmpty && measure.isEmpty || ingredient == " " || measure == " " {
                return
            } else {
                self.ingredients.append(ingredient)
                self.measurements.append(measure)
            }
        }
    }
}
