//
//  SignUpViewController.swift
//  Pifagor
//
//  Created by Элина Карапетян on 27.11.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        signUpView.buttonTouched = {[weak self] param, name, email, password in
            switch param{
            case button.SignIn:
                self?.signIn(name: name, email: email, password: password)
            case button.SignUp:
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func loadView() {
        view = signUpView
    }
    
    private func signIn(name: String, email: String, password: String){
        if name == ""{
            callAlert(error: MyError.noNameError)
            return
        }
        if email == ""{
            callAlert(error: MyError.noEmailError)
            return
        }
        if password == "" {
            callAlert(error: MyError.noPasswordError)
            return
        }
        let userRequest = SignUpUserRequest(name: name, email: email, password: password)
        AuthService.shared.signUpUser(with: userRequest) { [self] wasSignedUp, err in
            if let error = err{
                callAlert(error: error)
                return
            }
            else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func callAlert(error: Error){
        AlertManager.shared.callAlert(error: error)
    }
    
}
