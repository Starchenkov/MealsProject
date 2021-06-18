//
//  MainTabBar.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import UIKit

final class MainTabBar
{
    private let tabbar: UITabBarController
    
    private let randomScreenViewController: UIViewController
    private let randomScreenNavController: UINavigationController
    private let favouriteScreenViewController: UIViewController
    private let favouriteScreenNavController: UINavigationController
    private let categoriesScreenViewController: UIViewController
    private let categoriesScreenNavController: UINavigationController
    private let user: UserModel
    
    init(user: UserModel) {
        self.user = user
        self.tabbar = UITabBarController()
        self.randomScreenViewController = RandomScreenAssembly().build(user: user)
        self.randomScreenNavController = UINavigationController(rootViewController: self.randomScreenViewController)
        self.favouriteScreenViewController = FavouriteScreenAssembly().build(user: user)
        self.favouriteScreenNavController = UINavigationController(rootViewController: self.favouriteScreenViewController)
        self.categoriesScreenViewController = CategoriesScreenAssembly().build(user: user)
        self.categoriesScreenNavController = UINavigationController(rootViewController: categoriesScreenViewController)
        self.configureRandomScreenViewController()
        self.configureCategoriesScreenViewController()
        self.configureFavoriteScreenViewController()
        self.tabbar.setViewControllers([self.randomScreenNavController,
                                        self.categoriesScreenNavController,
                                        self.favouriteScreenNavController], animated: true)
        self.tabbar.tabBar.shadowImage = UIImage()
        self.tabbar.tabBar.backgroundImage = UIImage(named: Constants.tabBarBackgroundImageName)
        UITabBar.appearance().tintColor = ConstantsCorol.mainYellowColor
    }
    
    func getTabBar() -> UITabBarController {
        return self.tabbar
    }
    
    private func configureRandomScreenViewController() {
        self.randomScreenViewController.tabBarItem.image = UIImage(systemName: Constants.randomScreenImageTabBarName)
    }
    
    private func configureFavoriteScreenViewController() {
        self.favouriteScreenViewController.tabBarItem.image = UIImage(systemName: Constants.favoriteScreenImageTabBarName)
    }
    
    private func configureCategoriesScreenViewController() {
        self.categoriesScreenViewController.tabBarItem.image = UIImage(systemName: Constants.categoriesScreenImageTabBarName)
    }
}
