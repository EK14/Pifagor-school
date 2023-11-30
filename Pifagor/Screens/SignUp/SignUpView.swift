//
//  SignUpView.swift
//  Pifagor
//
//  Created by Элина Карапетян on 27.11.2023.
//

import UIKit

class SignUpView: UIView {

    var buttonTouched: ((button, String, String, String)->Void)?
    
    private lazy var image: UIImageView = {
        let label = UIImageView()
        label.image = UIImage(named: "label")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signInLabel: UILabel = {
        let signInLabel = UILabel()
        signInLabel.text = "Зарегистрироваться"
        signInLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        return signInLabel
    }()
    
    private lazy var signInYourAccountLabel: UILabel = {
        let signInYourAccountLabel = UILabel()
        signInYourAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        signInYourAccountLabel.textColor = .lightGray
        signInYourAccountLabel.text = "Создайте ваш аккаунт"
        signInYourAccountLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return signInYourAccountLabel
    }()
    
    private lazy var usernameTextField: UITextField = {
        let username = UITextField()
        username.translatesAutoresizingMaskIntoConstraints = false
        username.placeholder = "Имя"
        username.backgroundColor = UIColor(named: "lightgray")
        username.layer.cornerRadius = 10
        username.leftViewMode = .always
        username.leftView = UIView(frame: CGRect(x:0,y:0,width:16,height:0))
        return username
    }()
    
    private lazy var emailTextField: UITextField = {
        let username = UITextField()
        username.translatesAutoresizingMaskIntoConstraints = false
        username.placeholder = "Email"
        username.backgroundColor = UIColor(named: "lightgray")
        username.layer.cornerRadius = 10
        username.leftViewMode = .always
        username.leftView = UIView(frame: CGRect(x:0,y:0,width:16,height:0))
        return username
    }()
    
    private lazy var password: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.placeholder = "Пароль"
        password.backgroundColor = UIColor(named: "lightgray")
        password.layer.cornerRadius = 10
        password.leftViewMode = .always
        password.leftView = UIView(frame: CGRect(x:0,y:0,width:16,height:0))
        return password
    }()
    
    private lazy var signInBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "orange")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Зарегистрироваться", for: .normal)
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(signInBtnDidTouched), for: .touchUpInside)
        return btn
    }()
    
    private lazy var signUpBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Уже есть аккаунт", for: .normal)
        btn.layer.cornerRadius = 10
        btn.setTitleColor(UIColor(named: "orange"), for: .normal)
        btn.titleLabel?.font =  UIFont.systemFont(ofSize: 15, weight: .bold)
        btn.addTarget(self, action: #selector(signUpBtnDidTouched), for: .touchUpInside)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundColor()
        setupImage()
        setupSignInLabel()
        setupSignInYourAccountLabel()
        setupTextFields()
        setupBtn()
        setupSignUpBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundColor(){
        backgroundColor = .white
    }
    
    //MARK: Constraints
    
    private func setupImage(){
        addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 108),
            image.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupSignInLabel(){
        addSubview(signInLabel)
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            signInLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupSignInYourAccountLabel(){
        addSubview(signInYourAccountLabel)
        NSLayoutConstraint.activate([
            signInYourAccountLabel.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 5),
            signInYourAccountLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupTextFields(){
        addSubview(usernameTextField)
        addSubview(emailTextField)
        addSubview(password)
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: signInYourAccountLabel.bottomAnchor, constant: 30),
            usernameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            password.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            password.centerXAnchor.constraint(equalTo: centerXAnchor),
            password.heightAnchor.constraint(equalToConstant: 50),
            password.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            password.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
        ])
    }
    
    private func setupBtn(){
        addSubview(signInBtn)
        NSLayoutConstraint.activate([
            signInBtn.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20),
            signInBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInBtn.heightAnchor.constraint(equalToConstant: 50),
            signInBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            signInBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
        ])
    }
    
    private func setupSignUpBtn(){
        addSubview(signUpBtn)
        NSLayoutConstraint.activate([
            signUpBtn.topAnchor.constraint(equalTo: signInBtn.bottomAnchor, constant: 5),
            signUpBtn.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    // MARK: Actions
    
    @objc
    private func signInBtnDidTouched(){
        buttonTouched?(button.SignIn, usernameTextField.text!, emailTextField.text!, password.text!)
    }
    
    @objc
    private func signUpBtnDidTouched(){
        buttonTouched?(button.SignUp, "", "", "")
    }

}
