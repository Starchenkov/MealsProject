//
//  IMealStorage.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

protocol IMealStorage
{
    func getMeals(for user: UserModel) -> [MealModel]
    func createMeal(meal: MealModel, completion: @escaping () -> Void)
    func removeMeal(meal: MealModel)
    func checkFavoriteMeal(for user: UserModel, meal: MealModel) -> Bool
}
