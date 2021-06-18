//
//  RandomScreenAssembly.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import UIKit

class RandomScreenAssembly
{
    func build(user: UserModel) -> UIViewController {
        let networkManager = NetworkManager.instance
        let router = RandomScreenRouter()
        let presenter = RandomScreenPresenter(user: user,
                                              networkManager: networkManager,
                                              router: router)
        let controller = RandomScreenViewController(presenter: presenter)
        router.controller = controller
        return controller
    }
}
