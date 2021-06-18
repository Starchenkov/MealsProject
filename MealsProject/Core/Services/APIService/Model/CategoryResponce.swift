//
//  CategoryResponce.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 17.06.2021.
//

import Foundation

struct CategoriesResponce: Decodable
{
    let categories: [CategoryResponce]
}

struct CategoryResponce: Decodable
{
    private enum CodingKeys: String, CodingKey {
        case name = "strCategory"
        case imageURL = "strCategoryThumb"
    }
    
    let name: String
    let imageURL: String
}
