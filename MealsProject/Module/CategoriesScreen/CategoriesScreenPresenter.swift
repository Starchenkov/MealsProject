//
//  CategoriesScreenPresenter.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 17.06.2021.
//

import Foundation

protocol ICategoriesScreenPresenter
{
    func viewDidLoad(view: ICategoriesScreenView)
    func getCategoryCount() -> Int
    func configureCategoryCell(cell: CategoryScreenCell, indexPath: IndexPath)
    func getMealsCount() -> Int
    func configureMealListCell(cell: MealListScreenCell, indexPath: IndexPath)
    func selecteedCategory(indexPath: IndexPath)
    func showMealFull(indexPath: IndexPath)
}

class CategoriesScreenPresenter
{
    private weak var view: ICategoriesScreenView?
    private let user: UserModel
    private let networkManager: INetworkManager
    private let router: ICategoriesScreenRouter
    private var categoriesArray = [CategoryModel]()
    private var mealsListArray = [MealListModel]()
    
    init(user: UserModel, networkManager: INetworkManager, router: ICategoriesScreenRouter) {
        self.user = user
        self.networkManager = networkManager
        self.router = router
    }
}

extension CategoriesScreenPresenter: ICategoriesScreenPresenter
{
    func viewDidLoad(view: ICategoriesScreenView) {
        self.view = view
        self.displayCategories()
    }

    func getCategoryCount() -> Int {
        return self.categoriesArray.count
    }
    
    func configureCategoryCell(cell: CategoryScreenCell, indexPath: IndexPath) {
        let category = self.categoriesArray[indexPath.row]
        let viewModelCell = self.convertCategoryModelToCellViewModel(category: category)
        cell.set(vm: viewModelCell)
        
    }
    
    func getMealsCount() -> Int {
        return self.mealsListArray.count
    }
    
    func configureMealListCell(cell: MealListScreenCell, indexPath: IndexPath) {
            let meal = self.mealsListArray[indexPath.row]
            let viewModelCell = self.convertMealListModelToCellViewModel(meal: meal)
            cell.set(vm: viewModelCell)
    }
    
    func selecteedCategory(indexPath: IndexPath) {
        let selecteedCategory = categoriesArray[indexPath.row].name
        self.displayMealsByCategory(name: selecteedCategory)
    }
    
    func showMealFull(indexPath: IndexPath) {
        let mealId = self.mealsListArray[indexPath.row].id
        let url = API.detailByIdBaseURL.rawValue + mealId
        self.networkManager.fetchRequest(with: url, modelType: MealsResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let modelResponse):
                guard let modelResponce = modelResponse.meals.first else { return }
                let meal = self.convertMealModelResponceToMealModel(response: modelResponce)
                DispatchQueue.main.async {
                    self.router.showFullMeal(user: self.user, meal: meal)
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
}

private extension CategoriesScreenPresenter
{
    private func displayCategories() {
        self.networkManager.fetchRequest(with: API.categoriesURL.rawValue, modelType: CategoriesResponce.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let modelResponse):
                self.categoriesArray = self.convertCategoriesModelResponceToCategoryModel(response: modelResponse)
                if let firstCategory = self.categoriesArray.first?.name {
                    self.displayMealsByCategory(name: firstCategory)
                }
                DispatchQueue.main.async {
                    self.view?.updateCategoryCollection()
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
    
    private func displayMealsByCategory(name: String) {
        let url = API.mealsByCategoryBaseURL.rawValue + name
        self.networkManager.fetchRequest(with: url, modelType: MealListsResponce.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let modelResponse):
                self.mealsListArray = self.convertMealListsModelResponseToMealListModel(response: modelResponse)
                DispatchQueue.main.async {
                    self.view?.updateMealsTable()
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
    
    private func convertMealListModelToCellViewModel(meal: MealListModel) -> MealListCellViewModel {
        let viewModelCell = MealListCellViewModel(name: meal.name,
                                                  image: meal.imageURL)
        return viewModelCell
    }
    
    private func convertMealListsModelResponseToMealListModel(response: MealListsResponce) -> [MealListModel] {
        let meals = response.meals.map { MealListModel(name: $0.name,
                                                       imageURL: $0.imageURL,
                                                       id: $0.id)}
        return meals
    }
    
    private func convertIngredients(response: MealResponse) -> String {
        var str = ""
        for index in 0...response.ingredients.count - 1 {
            str += "\(response.ingredients[index]) - \(response.measurements[index])\r\n"
        }
        return str
    }
    
    private func convertCategoriesModelResponceToCategoryModel(response: CategoriesResponce) -> [CategoryModel] {
        let categories = response.categories.map { CategoryModel(name: $0.name,
                                                                 image: $0.imageURL) }
        return categories
    }
    
    private func convertCategoryModelToCellViewModel(category: CategoryModel) -> CategoryCellViewModel {
        let viewModelCell = CategoryCellViewModel(name: category.name, image: category.image)
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
}
