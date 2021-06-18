//
//  RandomScreenRouter.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import UIKit

protocol IRandomScreenRouter
{
    func showFullMeal(user: UserModel, meal: MealModel)
}

class RandomScreenRouter: IRandomScreenRouter
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
