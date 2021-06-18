//
//  FullScreenAssembly.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 14.06.2021.
//

import UIKit

class FullScreenAssembly
{
    func build(user: UserModel, meal: MealModel) -> UIViewController {
        let mealStorage = CoreDataStorage.instance
        let router = FullScreenRouter()
        let presenter = FullScreenPresenter(user: user,
                                            meal: meal,
                                            mealStorage: mealStorage,
                                            router: router)
        let controller = FullScreenViewController(presenter: presenter)
        router.controller = controller
        return controller
    }
}
