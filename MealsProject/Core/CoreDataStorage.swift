//
//  CoreDataStorage.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import Foundation
import CoreData

final class CoreDataStorage
{
    private init() {}
    static let instance = CoreDataStorage()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.containerNameCoreData)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension CoreDataStorage: IUserStorage
{
    func getUser(login: String, password: String) -> UserModel? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(User.login)) = '\(login)' && \(#keyPath(User.password)) = '\(password)'")
        guard let object = try? self.container.viewContext.fetch(fetchRequest).first else { return nil }
        return UserModel(user: object)
    }
    
    func saveUser(user: UserModel, completion: @escaping () -> Void) {
        self.container.performBackgroundTask { context in
            let object = User(context: context)
            object.uid = user.uid
            object.login = user.login
            object.password = user.password
            try? context.save()
            DispatchQueue.main.async{ return completion() }
        }
    }
}

extension CoreDataStorage: IMealStorage
{
    func getMeals(for user: UserModel) -> [MealModel] {
        let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Meal.holder.uid)) = %@", user.uid.uuidString)
        do {
            let result = try self.container.viewContext.fetch(fetchRequest).compactMap { MealModel(meal: $0) }
            return result
        } catch {
            return [MealModel]()
        }
    }
    
    func createMeal(meal: MealModel, completion: @escaping () -> Void) {
        self.container.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "\(#keyPath(User.uid)) = %@", meal.holder.uuidString)
            do {
                if let user = try context.fetch(fetchRequest).first {
                    let favoriteMeal = Meal(context: context)
                    favoriteMeal.holder = user
                    favoriteMeal.uid = meal.id
                    favoriteMeal.name = meal.name
                    favoriteMeal.category = meal.category
                    favoriteMeal.area = meal.area
                    favoriteMeal.instructions = meal.instructions
                    favoriteMeal.ingredients = meal.ingredients
                    favoriteMeal.imageURL = meal.image
                    favoriteMeal.youtubeURL = meal.youtubeUrl
                    favoriteMeal.sourceURL = meal.sourceUrl
                }
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async { completion() }
        }
    }
    
    func removeMeal(meal: MealModel) {
        self.container.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Meal.uid)) = %@", meal.id)
            do {
                if let removedMeal = try context.fetch(fetchRequest).first {
                    context.delete(removedMeal)
                    try context.save()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func checkFavoriteMeal(for user: UserModel, meal: MealModel) -> Bool {
        let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Meal.holder.uid)) = %@ AND \(#keyPath(Meal.uid)) = %@", user.uid.uuidString, meal.id)
        do {
            if let _ = try self.container.viewContext.fetch(fetchRequest).first {
                return true
            }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}
