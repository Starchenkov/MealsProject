//
//  FavouriteScreenPresenter.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import Foundation

protocol IFavouriteScreenPresenter
{
    func viewDidLoad(view: IFavouriteScreenView)
    func getCountFavouriteMeals() -> Int
    func configureCell(cell: FavouriteScreenCell, indexPath: IndexPath)
    func removeFavouriteMeal(at indextPath: IndexPath)
    func showMealFull(indexPath: IndexPath)
}

class FavouriteScreenPresenter
{
    private weak var view: IFavouriteScreenView?
    private let user: UserModel
    private let mealStorage: IMealStorage
    private let router: IFavouriteScreenRouter
    private var favouritesArray = [MealModel]()
    
    init(user: UserModel, mealStorage: IMealStorage, router: IFavouriteScreenRouter) {
        self.user = user
        self.mealStorage = mealStorage
        self.router = router
    }
}

extension FavouriteScreenPresenter: IFavouriteScreenPresenter
{
    func viewDidLoad(view: IFavouriteScreenView) {
        self.view = view
        self.displayFavouritesList()
    }
    
    func getCountFavouriteMeals() -> Int {
        self.favouritesArray.count
    }
    
    func configureCell(cell: FavouriteScreenCell, indexPath: IndexPath) {
        let favouriteMeal = favouritesArray[indexPath.row]
        let viewModel = convertMealModelToCellViewModel(meal: favouriteMeal)
        cell.set(vm: viewModel)
    }
    
    func showMealFull(indexPath: IndexPath) {
        let meal = favouritesArray[indexPath.row]
        self.router.showFullMeal(user: user, meal: meal)
    }
    
    func removeFavouriteMeal(at indextPath: IndexPath) {
        let meal = favouritesArray[indextPath.row]
        self.mealStorage.removeMeal(meal: meal)
        self.favouritesArray.remove(at: indextPath.row)
        DispatchQueue.main.async {
            self.view?.updateUI()
        }
    }
}

private extension FavouriteScreenPresenter
{
    private func convertMealModelToCellViewModel(meal: MealModel) -> FavouriteCellViewModel {
        let viewModelCell = FavouriteCellViewModel(name: meal.name,
                                                   image: meal.image,
                                                   category: meal.category,
                                                   area: meal.area)
        return viewModelCell
    }
    
    private func displayFavouritesList() {
        let result = mealStorage.getMeals(for: user)
        self.favouritesArray = result
        DispatchQueue.main.async {
            self.view?.updateUI()
        }
    }
    
}
