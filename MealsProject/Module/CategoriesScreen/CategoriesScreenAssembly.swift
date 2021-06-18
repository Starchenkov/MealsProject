//
//  CategoriesScreenAssembly.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 17.06.2021.
//

import UIKit

class CategoriesScreenAssembly
{
    func build(user: UserModel) -> UIViewController {
        let networkManager = NetworkManager.instance
        let router = CategoriesScreenRouter()
        let presenter = CategoriesScreenPresenter(user: user,
                                              networkManager: networkManager,
                                              router: router)
        let controller = CategoriesScreenViewController(presenter: presenter)
        router.controller = controller
        return controller
    }
}
