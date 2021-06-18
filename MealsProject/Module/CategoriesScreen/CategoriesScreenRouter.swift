//
//  CategoriesScreenRouter.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 17.06.2021.
//

import UIKit

protocol ICategoriesScreenRouter
{
    func showFullMeal(user: UserModel, meal: MealModel)
}

class CategoriesScreenRouter: ICategoriesScreenRouter
{
    var controller: UIViewController?
    
    func showFullMeal(user: UserModel, meal: MealModel) {
        let mealStorage = CoreDataStorage.instance
        let router = FullScreenRouter()
        let presenter = FullScreenPresenter(user: user, meal: meal, mealStorage: mealStorage, router: router)
        let controller = FullScreenViewController(presenter: presenter)
        router.controller = controller
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .fullScreen
        self.controller?.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
