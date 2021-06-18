//
//  FavouriteAssembly.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import UIKit

class FavouriteScreenAssembly
{
    func build(user: UserModel) -> UIViewController {
        let mealStorage = CoreDataStorage.instance
        let router = FavouriteScreenRouter()
        let presenter = FavouriteScreenPresenter(user: user,
                                                mealStorage: mealStorage,
                                                router: router)
        let controller = FavouriteScreenViewController(presenter: presenter)
        router.controller = controller
        return controller
    }
}
