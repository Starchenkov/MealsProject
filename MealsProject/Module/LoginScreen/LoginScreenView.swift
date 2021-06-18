//
//  LoginScreenView.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import UIKit
import SnapKit

protocol ILoginScreenViewDelegate: AnyObject
{
    func login(login: String?, password: String?)
    func signin(login: String?, password: String?)
}

final class LoginScreenView: UIView
{
    weak var delegate: ILoginScreenViewDelegate?
    
    private var textLoginLable: UILabel = {
        var lable = UILabel()
        lable.text = Constants.loginScreenTextLable
        lable.font = UIFont.boldSystemFont(ofSize: 28)
        return lable
    }()
    
    private var infoStackContainer: UIStackView = {
        var container = UIStackView()
        container.axis = .vertical
        container.spacing = 50
        return container
    }()
    
    private var loginTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = Constants.loginTextFieldPlaceHolder
        textField.addBottomBorder()
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = Constants.passwordTextFieldPlaceHolder
        textField.isSecureTextEntry = true
        textField.addBottomBorder()
        return textField
    }()
    
    private var loginButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = ConstantsCorol.mainYellowColor
        button.layer.cornerRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        button.layer.shadowOpacity = 0.15
        button.layer.shadowRadius = 2.0
        button.setTitle(Constants.loginButtonText, for: .normal)
        button.addTarget(self, action: #selector(onLoginClick), for: .touchUpInside)
        return button
    }()
    
    private var signinButton: UIButton = {
        var view = UIButton(type: .system)
        view.setTitle(Constants.signinButtonText, for: .normal)
        view.addTarget(self, action: #selector(onSignClick), for: .touchUpInside)
        return view
    }()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubviews()
        self.makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginScreenView
{
    private func addSubviews() {
        self.addSubview(self.textLoginLable)
        self.addSubview(self.signinButton)
        self.addSubview(self.infoStackContainer)
        self.infoStackContainer.addArrangedSubview(self.loginTextField)
        self.infoStackContainer.addArrangedSubview(self.passwordTextField)
        self.infoStackContainer.addArrangedSubview(self.loginButton)
    }
    
    private func makeConstraints() {
        textLoginLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(100)
        }
        infoStackContainer.snp.makeConstraints { make in
            make.top.equalTo(textLoginLable.snp.bottom).offset(80)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right).offset(-20)
        }
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(self.loginButton.snp.width).multipliedBy(0.15)
        }
        signinButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(30)
        }
    }
    
    @objc private func onLoginClick() {
        self.delegate?.login(login: self.loginTextField.text, password: self.passwordTextField.text)
    }
    
    @objc private func onSignClick() {
        self.delegate?.signin(login: self.loginTextField.text, password: self.passwordTextField.text)
    }
}
