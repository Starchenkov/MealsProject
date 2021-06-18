//
//  LoginScreenAssembly.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import UIKit

final class LoginScreenAssembly
{
    func build() -> UIViewController {
        let userStorage = CoreDataStorage.instance
        let router = LoginScreenRouter()
        let presenter = LoginScreenPresenter(userStorage: userStorage, router: router)
        let controller = LoginScreenViewController(presenter: presenter)
        return controller
    }
}
