//
//  LoginScreenRouter.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import UIKit

protocol ILoginScreenRouter
{
    func openMainTabBar(user: UserModel)
}

class LoginScreenRouter: ILoginScreenRouter
{
    func openMainTabBar(user: UserModel) {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
        let tabBarController = MainTabBar(user: user).getTabBar()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
