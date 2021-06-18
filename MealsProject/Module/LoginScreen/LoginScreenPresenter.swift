//
//  LoginScreenPresenter.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import Foundation
import CryptoKit

protocol ILoginScreenPresenter: ILoginScreenViewDelegate
{
    func viewDidLoad(view: ILoginScreenView)
}

final class LoginScreenPresenter
{
    private weak var view: ILoginScreenView?
    private let userStorage: IUserStorage
    private let router: ILoginScreenRouter
    
    init(userStorage: IUserStorage, router: ILoginScreenRouter) {
        self.userStorage = userStorage
        self.router = router
    }
}

extension LoginScreenPresenter: ILoginScreenPresenter
{
    func viewDidLoad(view: ILoginScreenView) {
        self.view = view
    }
}

extension LoginScreenPresenter: ILoginScreenViewDelegate
{
    func login(login: String?, password: String?) {
        guard let login = login, login.isEmpty == false, let password = password, password.isEmpty == false else {
            self.view?.showAlert(message: Constants.loginScreenValidationAlertMessage)
            return
        }
        guard let user = self.userStorage.getUser(login: login, password: self.MD5(password)) else {
            self.view?.showAlert(message: Constants.loginScreenValidationMessage)
            return
        }
        self.router.openMainTabBar(user: user)
    }
    
    func signin(login: String?, password: String?) {
        guard let login = login, login.isEmpty == false, let password = password, password.isEmpty == false else {
            self.view?.showAlert(message: Constants.loginScreenValidationAlertMessage)
            return
        }
        guard self.userStorage.getUser(login: login, password: self.MD5(password)) == nil else {
            self.view?.showAlert(message: Constants.loginScreenValidationUserMessage)
            return
        }
        let newUser = UserModel(login: login, password: self.MD5(password))
        print(MD5(password))
        self.userStorage.saveUser(user: newUser, completion: {
            self.router.openMainTabBar(user: newUser)
        })
    }
}

private extension LoginScreenPresenter
{
    private func MD5(_ string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
