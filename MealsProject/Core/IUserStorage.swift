//
//  IUserStorage.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

protocol IUserStorage
{
    func getUser(login: String, password: String) -> UserModel?
    func saveUser(user: UserModel, completion: @escaping () -> Void)
}
