//
//  MealListResponse.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 17.06.2021.
//
import Foundation

struct MealListsResponce: Decodable
{
    let meals: [MealListResponce]
}

struct MealListResponce: Decodable
{
    private enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case imageURL = "strMealThumb"
        case id = "idMeal"
    }
    
    let name: String
    let imageURL: String
    let id: String
}
