//
//  MainScreenPresenter.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 12.06.2021.
//

import Foundation

protocol IRandomScreenPresenter
{
    func viewDidLoad(view: IRandomScreenView)
    func getCountMealsRow() -> Int
    func configureCell(cell: RandomScreenCell, indexPath: IndexPath)
    func showNewRandom()
    func showMealFull(indexPath: IndexPath)
}

class RandomScreenPresenter
{
    private weak var view: IRandomScreenView?
    private let user: UserModel
    private let networkManager: INetworkManager
    private let router: IRandomScreenRouter
    private var mealsArray = [MealModel]()
    
    init(user: UserModel, networkManager: INetworkManager, router: IRandomScreenRouter) {
        self.user = user
        self.networkManager = networkManager
        self.router = router
    }
}

extension RandomScreenPresenter: IRandomScreenPresenter
{
    func viewDidLoad(view: IRandomScreenView) {
        self.view = view
        self.displayRandomMeal()
    }
    
    func showNewRandom() {
        self.mealsArray.removeAll()
        self.displayRandomMeal()
    }
    
    func getCountMealsRow() -> Int {
        return self.mealsArray.count
    }
    
    func configureCell(cell: RandomScreenCell, indexPath: IndexPath) {
        let meal = self.mealsArray[indexPath.row]
        let viewModelCell = self.convertMealModelToCellViewModel(meal: meal)
        cell.set(vm: viewModelCell)
        
    }
    
    func showMealFull(indexPath: IndexPath) {
        let meal = self.mealsArray[indexPath.row]
        self.router.showFullMeal(user: user, meal: meal)
    }
}

private extension RandomScreenPresenter
{
    private func displayRandomMeal() {
        self.networkManager.fetchRequest(with: API.randomURL.rawValue, modelType: MealsResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let modelResponse):
                guard let modelResponce = modelResponse.meals.first else { return }
                let mealRandomModel = self.convertMealModelResponceToMealModel(response: modelResponce)
                self.mealsArray.append(mealRandomModel)
                DispatchQueue.main.async {
                    self.view?.updateUI()
                }
                return
            case .failure( _):
                DispatchQueue.main.async {
                    self.view?.showAlert(message: Constants.alertMessageRequestError)
                }
                break
            }
        }
    }
    
    private func convertMealModelToCellViewModel(meal: MealModel) -> RandomCellViewModel {
        let viewModelCell = RandomCellViewModel(name: meal.name,
                                                image: meal.image,
                                                category: meal.category,
                                                area: meal.area)
        return viewModelCell
    }
    
    private func convertMealModelResponceToMealModel(response: MealResponse) -> MealModel {
        let mealModel = MealModel(holder: user.uid,
                                  id: response.id,
                                  name: response.name,
                                  category: response.category,
                                  area: response.area,
                                  instructions: response.instructions,
                                  image: response.imageURL,
                                  youtubeUrl: response.youtubeURL ?? "",
                                  ingredients: self.convertIngredients(response: response),
                                  sourceUrl: response.sourceUrl ?? "")
        return mealModel
    }
    
    private func convertIngredients(response: MealResponse) -> String {
        var str = ""
        for index in 0...response.ingredients.count - 1 {
            str += "\(response.ingredients[index]) - \(response.measurements[index])\r\n"
        }
        return str
    }
    
}
