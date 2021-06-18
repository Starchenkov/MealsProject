//
//  LoginScreenViewController.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import UIKit

protocol ILoginScreenView: AnyObject
{
    func showAlert(message: String)
}

final class LoginScreenViewController: UIViewController
{
    private var presenter: ILoginScreenPresenter
    private let customView: LoginScreenView
    
    init(presenter: ILoginScreenPresenter) {
        self.presenter = presenter
        self.customView = LoginScreenView()
        self.customView.delegate = self.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad(view: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.customView.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}

extension LoginScreenViewController: ILoginScreenView
{
    func showAlert(message: String) {
        let alert = UIAlertController(title: Constants.alertTitleLogin, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.alertActionTextOK, style: .default, handler:  nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
