//
//  FullScreenPresenter.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 14.06.2021.
//

import Foundation
import UIKit

protocol IFullScreenPresenter: IFullScreenViewDelegate
{
    func viewDidLoad(view: IFullScreenView)
    func close()
    func saveInFavorite()
}

class FullScreenPresenter
{
    private weak var view: IFullScreenView?
    private let mealStorage: IMealStorage
    private let router: IFullScreenRouter
    private let user: UserModel
    private var meal: MealModel
    
    init(user: UserModel, meal: MealModel, mealStorage: IMealStorage, router: IFullScreenRouter) {
        self.user = user
        self.meal = meal
        self.mealStorage = mealStorage
        self.router = router
    }
}

extension FullScreenPresenter: IFullScreenPresenter
{
    func viewDidLoad(view: IFullScreenView) {
        self.view = view
        self.displayMeal()
    }
    
    func close() {
        self.router.close()
    }
    
    func saveInFavorite() {
        if self.meal.inFavorite {
            self.meal.inFavorite = false
            self.mealStorage.removeMeal(meal: self.meal)
            self.view?.setFavouriteImage(state: self.meal.inFavorite)
        } else {
            self.mealStorage.createMeal(meal: self.meal) {
                self.meal.inFavorite = true
                DispatchQueue.main.async {
                    self.view?.setFavouriteImage(state: self.meal.inFavorite)
                }
            }
        }
    }
    
    func showYoutube() {
        if let url = URL(string: self.meal.youtubeUrl ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func showSource() {
        if let url = URL(string: self.meal.sourceUrl ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

private extension FullScreenPresenter
{
    private func displayMeal() {
        let vm = convertMealModelToFullScreenViewModel()
        self.view?.set(vm: vm)
    }

    private func convertMealModelToFullScreenViewModel() -> FullScreeViewModel {
        self.meal.inFavorite = mealStorage.checkFavoriteMeal(for: self.user, meal: self.meal)
        let viewModel = FullScreeViewModel(image: self.meal.image,
                                           name: self.meal.name,
                                           category: self.meal.category,
                                           area: self.meal.area,
                                           instructions: self.meal.instructions,
                                           ingredients: self.meal.ingredients,
                                           youtube: self.meal.youtubeUrl?.isEmpty ?? true,
                                           source: self.meal.sourceUrl?.isEmpty ?? true,
                                           inFavorites: self.meal.inFavorite)
        return viewModel
    }
}
